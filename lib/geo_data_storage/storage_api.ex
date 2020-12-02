defmodule GeoDataStorage.StorageAPI do
  @moduledoc """
  Expose API for external services that use this library
  """

  alias GeoDataStorage.DatabaseContext

  alias GeoDataStorage.Model.GeoData
  alias GeoDataStorage.Report.ImportReport

  @doc """
  Looks for given record by IP address.
  Returns {:ok, record} if record has found.
  Return {:error, binary} if given argument is not IP address.
  """
  @spec get_location_by_ip(binary) :: {:ok, GeoData.t} | {:error, binary}
  def get_location_by_ip(ip_address) do
    sanitized_address = String.trim(ip_address)
    with true <- Regex.match?(GeoData.ip_address_regex(), sanitized_address),
          %GeoData{} = geo_data <- DatabaseContext.find_by_ip_address(sanitized_address) do
      {:ok, geo_data}
    else
      false ->
        {:error, "Given argument (#{ip_address}) is not IP address"}

      nil ->
        {:error, "Geo Data with ip_address #{ip_address} not found"}
    end
  end

  @doc """
  Input given file content into database
  """
  @spec parse_csv_file(binary) :: {:ok, ImportReport.t}
  def parse_csv_file(file) do
    file
    |> File.stream!
    |> CSV.decode(
         num_workers: get_workers(),
         headers: true,
         validate_row_length: true
       )
    |> Stream.with_index()
    |> Task.async_stream(&persist_record/1, max_concurrency: get_workers())
    |> Enum.reduce(%ImportReport{}, fn result, report ->
      result
      |> case do
           {:ok, _success} ->
              ImportReport.increase_success(report)
           {:error, reason} ->
              ImportReport.add_error(report, reason)
         end
    end)
    |> (fn report ->
      {:ok, ImportReport.reverse_errors(report)}
        end).()
  end

  defp get_workers, do: System.schedulers_online()

  @spec persist_record({tuple, integer}) :: {:ok, any} | {:error, any}
  defp persist_record({{:ok, attributes}, index}) do
    attributes
    |> DatabaseContext.create_geo_data()
    |> case do
         {:ok, %{ip_address: ip_address}} ->
           {:ok, "#{prefix(index)} Successfully added record for #{ip_address}"}
         {:error, %Ecto.Changeset{errors: errors}} ->
           {:error, "#{prefix(index)} Unable to add record. Errors: #{inspect(errors)}"}
       end
  end

  defp persist_record({{:error, reason}, index}) do
    {:error, "#{prefix(index)} Csv file row invalid: #{inspect(reason)}"}
  end

  defp prefix(index), do: "Row number: #{index}"
end