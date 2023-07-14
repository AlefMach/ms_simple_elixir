defmodule SimpleMsBlocklist.Context.BlocklistLogs do
  @moduledoc """
  The Logs context.
  """

  import Ecto.Query, warn: false
  alias SimpleMsBlocklist.Repo

  alias SimpleMsBlocklist.Schemas.In.BlocklistLog

  @doc """
  Returns the list of blocklist_logs.

  ## Examples

      iex> list_blocklist_logs()
      [%BlocklistLog{}, ...]

  """
  def list_blocklist_logs do
    Repo.all(BlocklistLog)
  end

  @doc """
  Gets a single blocklist_log.

  Raises `Ecto.NoResultsError` if the Blocklist log does not exist.

  ## Examples

      iex> get_blocklist_log!(123)
      %BlocklistLog{}

      iex> get_blocklist_log!(456)
      ** (Ecto.NoResultsError)

  """
  def get_blocklist_log!(id), do: Repo.get!(BlocklistLog, id)

  @doc """
  Creates a blocklist_log.

  ## Examples

      iex> create_blocklist_log(%{field: value})
      {:ok, %BlocklistLog{}}

      iex> create_blocklist_log(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_blocklist_log(attrs \\ %{}) do
    %BlocklistLog{}
    |> BlocklistLog.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a blocklist_log.

  ## Examples

      iex> update_blocklist_log(blocklist_log, %{field: new_value})
      {:ok, %BlocklistLog{}}

      iex> update_blocklist_log(blocklist_log, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_blocklist_log(%BlocklistLog{} = blocklist_log, attrs) do
    blocklist_log
    |> BlocklistLog.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a blocklist_log.

  ## Examples

      iex> delete_blocklist_log(blocklist_log)
      {:ok, %BlocklistLog{}}

      iex> delete_blocklist_log(blocklist_log)
      {:error, %Ecto.Changeset{}}

  """
  def delete_blocklist_log(%BlocklistLog{} = blocklist_log) do
    Repo.delete(blocklist_log)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking blocklist_log changes.

  ## Examples

      iex> change_blocklist_log(blocklist_log)
      %Ecto.Changeset{data: %BlocklistLog{}}

  """
  def change_blocklist_log(%BlocklistLog{} = blocklist_log, attrs \\ %{}) do
    BlocklistLog.changeset(blocklist_log, attrs)
  end
end
