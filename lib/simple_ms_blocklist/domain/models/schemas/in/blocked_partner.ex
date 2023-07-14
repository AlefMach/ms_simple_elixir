defmodule SimpleMsBlocklist.Schemas.In.BlockedPartner do
  @moduledoc false

  use Ecto.Schema
  import Ecto.Changeset
  import Ecto.SoftDelete.Schema

  @optional_fields [
    :cnpj,
    :reason,
    :partner_id,
    :note,
    :expiration_date
  ]

  schema "blocked_partners" do
    field(:cnpj, :string)
    field(:expiration_date, :utc_datetime)
    field(:note, :string)
    field(:partner_id, :integer)
    field(:reason, Ecto.Enum, values: [:fraude, :alerta, :definitivo, :fraude_cpf, :temporario])

    timestamps()
    soft_delete_schema()
  end

  @doc false
  def changeset(blocked_partner, attrs) do
    blocked_partner
    |> cast(attrs)
    |> validate_required([:cnpj, :reason, :partner_id])
    |> unique_constraint(:cnpj, name: :cnpj)
  end

  defp cast(blocked_partner, %{cnpj: cnpj} = params) do
    if Brcpfcnpj.cnpj_valid?(cnpj) do
      attrs = Map.put(params, :cnpj, String.replace(cnpj, ~r/\W/, ""))

      cast(blocked_partner, attrs, @optional_fields)
    else
      changeset = change(blocked_partner, %{cnpj: cnpj})
      add_error(changeset, :cnpj, "CNPJ invalid")
    end
  end

  defp cast(blocked_partner, attrs),
    do: cast(blocked_partner, attrs, @optional_fields)
end
