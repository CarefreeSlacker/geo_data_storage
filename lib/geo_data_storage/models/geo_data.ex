defmodule GeoDataStorage.Model.GeoData do
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
    :mystery_value
  ]
  @required_fields [
    :ip_address,
    :country_code,
    :country,
    :city,
    :latitude,
    :longitude
  ]
  @type t :: %__MODULE__{}
  @ip_address_regex ~r/^\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}$/

  schema @table_name do
    field :ip_address, :string
    field :country_code, :string
    field :country, :string
    field :city, :string
    field :latitude, :float
    field :longitude, :float
    field :mystery_value, :integer

    timestamps()
  end

  def ip_address_regex, do: @ip_address_regex

  def changeset(entity \\ %__MODULE__{}, attrs) do
    entity
    |> cast(attrs, @cast_fields, [])
    |> validate_required(@required_fields)
    |> unique_constraint(:ip_address)
    |> validate_number(:longitude, less_than_or_equal_to: 180, greater_than_or_equal_to: -180)
    |> validate_number(:latitude, less_than_or_equal_to: 90, greater_than_or_equal_to: -90)
    |> validate_format(:ip_address, @ip_address_regex)
  end
end