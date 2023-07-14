defmodule SimpleMsBlocklist.Context.BlockedPartners do
  @moduledoc """
  The BlockedPartner context.
  """

  import Ecto.Query, warn: false
  alias SimpleMsBlocklist.Repo

  alias SimpleMsBlocklist.Schemas.In.BlockedPartner

  @doc """
  Returns the list of blocked_partner.

  ## Examples

      iex> list_all()
      [%BlockedPartner{}, ...]

  """
  def list_all do
    Repo.all(BlockedPartner)
  end

  @doc """
  Gets a single blocked_partner.

  Raises `Ecto.NoResultsError` if the BlockedPartner does not exist.

  ## Examples

      iex> get!(123)
      %BlockedPartner{}

      iex> get!(456)
      ** (Ecto.NoResultsError)

  """
  def get!(id), do: Repo.get!(BlockedPartner, id)

  @doc """
  Gets a single blocked_partner.

  Raises `Ecto.NoResultsError` if the BlockedPartner does not exist.

  ## Examples

      iex> get_by([cnpj: 1])
      %BlockedPartner{}

      iex> get_by([cnpj: 2])
      nil

  """
  def get_by(params), do: Repo.get_by(BlockedPartner, params)

  @doc """
  Creates a blocked_partner.

  ## Examples

      iex> create(%{field: value})
      {:ok, %BlockedPartner{}}

      iex> create(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create(attrs \\ %{}) do
    %BlockedPartner{}
    |> BlockedPartner.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a blocked_partner.

  ## Examples

      iex> update(blocked_partner, %{field: new_value})
      {:ok, %BlockedPartner{}}

      iex> update(blocked_partner, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update(%BlockedPartner{} = blocked_partner, attrs) do
    blocked_partner
    |> BlockedPartner.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  update column delete a blocked_partner.

  ## Examples

      iex> delete(blocked_partner)
      {:ok, %BlockedPartner{}}

      iex> delete(blocked_partner)
      {:error, %Ecto.Changeset{}}

  """
  def delete(%BlockedPartner{} = blocked_partner) do
    Repo.soft_delete(blocked_partner)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking blocked_partner changes.

  ## Examples

      iex> change(blocked_partner)
      %Ecto.Changeset{data: %BlockedPartner{}}

  """
  def change(%BlockedPartner{} = blocked_partner, attrs \\ %{}) do
    BlockedPartner.changeset(blocked_partner, attrs)
  end
end
