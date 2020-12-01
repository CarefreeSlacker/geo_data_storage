defmodule GeoDataStorage.GeoData do
  @moduledoc """
  Describe database table that contains country IP address coordinates
  """

  use Ecto.Schema
  import Ecto.Changeset

  @table_name Application.get_env(:geo_data_storage, :database_config)[:geo_data_table_name]
  @cast_fields [
    :ip_address,
    :country_code,
    :country,
    :city,
    :latitude,
    :longitude,
    :value
  ]
  @required_fields [
    :ip_address,
    :country_code,
    :country,
    :city,
    :latitude,
    :longitude,
    :value
  ]
  @type t :: %__MODULE__{}

  schema @table_name do
    field :ip_address, :string
    field :country_code, :string
    field :country, :string
    field :city, :string
    field :latitude, :float
    field :longitude, :float
    field :value, :integer

    timestamps()
  end

  def changeset(entity \\ %__MODULE__{}, attrs) do
    entity
    |> cast(attrs, @cast_fields, [])
    |> validate_required(@required_fields)
  end
end