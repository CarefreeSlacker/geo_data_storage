defmodule GeoDataStorage do
  @moduledoc """
  Documentation for GeoDataStorage.
  """
  use Application

  @doc """
   Loads configuration, starts all defined syncs, reports results
  """

  def children do
    [
      GeoDataStorage.Repo
    ]
  end

  def start(_type, _args) do
    opts = [strategy: :one_for_one, name: GeoDataStorage.Supervisor]
    Supervisor.start_link(children(), opts)
  end
end
