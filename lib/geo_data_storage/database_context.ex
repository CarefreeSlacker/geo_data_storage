defmodule GeoDataStorage.DatabaseContext do
  @moduledoc """
  Context for storing database interaction
  """

  import Ecto.Query, warn: false
  alias GeoDataStorage.Repo
  alias GeoDataStorage.Model.GeoData

  @doc """
  Returns the list of configuration_geo_datas.

  ## Examples

      iex> list_geo_datas()
      [%GeoData{}, ...]

  """
  def list_geo_data do
    GeoData
    |> order_by(:name)
    |> Repo.all()
  end

  @doc """
  Gets a single geo_data.

  Raises `Ecto.NoResultsError` if the GeoData does not exist.

  ## Examples

      iex> get_geo_data!(123)
      %GeoData{}

      iex> get_geo_data!(456)
      ** (Ecto.NoResultsError)

  """
  def get_geo_data!(id, preloads \\ []) do
    GeoData
    |> Repo.get!(id)
    |> Repo.preload(preloads)
  end

  @doc """
  Creates a geo_data.

  ## Examples

      iex> create_geo_data(%{field: value})
      {:ok, %GeoData{}}

      iex> create_geo_data(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_geo_data(attrs \\ %{}) do
    %GeoData{}
    |> GeoData.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a geo_data.

  ## Examples

      iex> update_geo_data(geo_data, %{field: new_value})
      {:ok, %GeoData{}}

      iex> update_geo_data(geo_data, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_geo_data(%GeoData{} = geo_data, attrs) do
    geo_data
    |> GeoData.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a GeoData.

  ## Examples

      iex> delete_geo_data(geo_data)
      {:ok, %GeoData{}}

      iex> delete_geo_data(geo_data)
      {:error, %Ecto.Changeset{}}

  """
  def delete_geo_data(%GeoData{} = geo_data) do
    Repo.delete(geo_data)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking geo_data changes.

  ## Examples

      iex> change_geo_data(geo_data)
      %Ecto.Changeset{geo_data: %GeoData{}}

  """
  def change_geo_data(%GeoData{} = geo_data) do
    GeoData.changeset(geo_data, %{})
  end
end