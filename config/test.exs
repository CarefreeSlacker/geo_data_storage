use Mix.Config

config :geo_data_storage, :database_config,
  otp_app: :geo_data_storage,
  adapter: Ecto.Adapters.Postgres,
  geo_data_table_name: "geo_data_table"

config :geo_data_storage, ecto_repos: [GeoDataStorage.Repo]

config :geo_data_storage, GeoDataStorage.Repo,
  database: "geo_data_database_test",
  username: "postgres",
  password: "postgres",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox,
  port: "5432"
