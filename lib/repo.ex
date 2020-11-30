defmodule GeoDataStorage.Repo do
  use Ecto.Repo,
      otp_app: :geo_data_storage,
      adapter: Application.get_env(:geo_data_storage, :repo_config)[:adapter]
end