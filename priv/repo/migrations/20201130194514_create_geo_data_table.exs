defmodule GeoDataStorage.Repo.Migrations.CreateGeoDataTable do
  use Ecto.Migration

  def change do
    create table(:geo_data_table) do
      add :ip_address, :string
      add :country_code, :string
      add :country, :string
      add :city, :string
      add :latitude, :float
      add :longitude, :float
      add :mystery_value, :bigint

      timestamps()
    end

    create unique_index(:geo_data_table, :ip_address)
  end
end
