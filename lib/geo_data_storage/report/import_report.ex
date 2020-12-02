defmodule GeoDataStorage.Report.ImportReport do
  @moduledoc """
  Contains fields to store statistics
  """

  defstruct success: 0, failed: 0, errors: []

  @type t :: %__MODULE__{}

  @spec increase_success(t) :: t
  def increase_success(%__MODULE__{success: success} = report) do
    %{report | success: success + 1}
  end

  @spec increase_failed(t) :: t
  def increase_failed(%__MODULE__{failed: failed} = report) do
    %{report | failed: failed + 1}
  end

  @spec add_error(t, binary) :: t
  def add_error(%__MODULE__{failed: failed, errors: errors} = report, error) do
    %{report | failed: failed + 1, errors: [error] ++ errors}
  end

  @spec reverse_errors(t) :: t
  def reverse_errors(%__MODULE__{errors: errors} = report) do
    %{report | errors: Enum.reverse(errors)}
  end
end