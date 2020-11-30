defmodule GeoDataStorage.GeoData do
  use Ecto.Schema

  @table_name Application.get_env()

  schema "geo_data" do
    field :city     # Defaults to type :string
    field :temp_lo, :integer
    field :temp_hi, :integer
    field :prcp,    :float, default: 0.0
  end
end