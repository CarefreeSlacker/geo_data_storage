defmodule GeoDataStorage.RepoCase do
  use ExUnit.CaseTemplate

  using do
    quote do
      alias GeoDataStorage.Repo

      import Ecto
      import Ecto.Query
      import GeoDataStorage.RepoCase

      # and any other stuff
    end
  end

  setup tags do
    :ok = Ecto.Adapters.SQL.Sandbox.checkout(GeoDataStorage.Repo)

    unless tags[:async] do
      Ecto.Adapters.SQL.Sandbox.mode(GeoDataStorage.Repo, {:shared, self()})
    end

    :ok
  end
end