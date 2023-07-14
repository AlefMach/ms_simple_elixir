defmodule SimpleMsBlocklist.Services.Blocklist do
  @moduledoc """
  Module for checking partner status
  """

  require Logger

  alias SimpleMsBlocklist.Context.BlockedPartners

  @status_to_set_blocked [
    "fraude"
  ]

  @doc """
  function that checks if the partner is blocked
  """
  def is_blocked?(cnpj) do
    blocklist_data = BlockedPartners.get_by(cnpj: cnpj)

    case blocklist_data do
      nil ->
        Logger.info("Cnpj não encontrado no banco de dados - cnpj: #{cnpj}")
        {:ok, false}

      _ ->
        Logger.info("Cnpj encontrado no banco de dados - cnpj: #{cnpj}")
        {:ok, Atom.to_string(blocklist_data.reason) in @status_to_set_blocked}
    end
  end

  @doc """
  function that checks if the cnpj is valid
  """
  def parse_cnpj(cnpj) do
    if Brcpfcnpj.cnpj_valid?(cnpj) do
      {:ok, String.replace(cnpj, ~r/\W/, "")}
    else
      Logger.error("Error ao tentar validar o CNPJ - cnpj: #{inspect(cnpj)}")
      {:error, "Invalid CNPJ"}
    end
  rescue
    error ->
      Logger.error("Error ao tentar validar o CNPJ - cnpj: #{cnpj} - error: #{error}")
  end
end
