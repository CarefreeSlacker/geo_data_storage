defmodule GeoDataStorage.StorageAPI do
  @moduledoc """
  Expose API for external services that use this library
  """

  alias GeoDataStorage.DatabaseContext

  @doc """
  Get record by IP
  """

  def parse_csv_file(file) do
    file
    |> File.stream!
    |> CSV.decode(
         num_workers: System.schedulers(),
         headers: true,
         validate_row_length: true
       )

  end
end