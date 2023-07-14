defmodule SimpleMsBlocklist.BlocklistsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `SimpleMsBlocklist.BlockedPartners` context.
  """

  @status [
    "fraude",
    "alerta",
    "definitivo",
    "fraude_cpf",
    "temporario"
  ]

  @doc """
  Generate a blocklist.
  """
  def blocklist_fixture(attrs \\ %{}) do
    {:ok, blocklist} =
      attrs
      |> Enum.into(%{
        cnpj: generate_cnpj(),
        deleted_at: ~U[2023-01-09 19:07:00Z],
        expiration_date: ~U[2023-01-09 19:07:00Z],
        note: "some note",
        partner_id: 42,
        reason: select_a_shuffle_reason()
      })
      |> SimpleMsBlocklist.Context.BlockedPartners.create()

    blocklist
  end

  def generate_cnpj() do
    Brcpfcnpj.cnpj_generate()
  end

  def select_a_shuffle_reason(),
    do: @status |> Enum.shuffle() |> Enum.at(1)
end
