use Mix.Config

config :geo_data_storage, :repo_config,
  otp_app: :geo_data_storage,
  adapter: Ecto.Adapters.Postgres

config :geo_data_storage, ecto_repos: GeoDataStorage.Repo

config :geo_data_storage, GeoDataStorage.Repo,
  database: "geo_data_database",
  username: "postgres",
  password: "postgres",
  hostname: "localhost",
  port: "5432"