defmodule GeoDataStorage.MixProject do
  use Mix.Project

  def project do
    [
      app: :geo_data_storage,
      version: "0.1.0",
      elixir: "~> 1.8",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      mod: {GeoDataStorage, []},
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      # Tools
      {:csv, "~> 2.3"},
      {:credo, "~> 1.1.0", only: [:dev, :test], runtime: false},
      # Database
      {:ecto_sql, "~> 3.0"},
      {:postgrex, ">= 0.0.0"}
    ]
  end
end
