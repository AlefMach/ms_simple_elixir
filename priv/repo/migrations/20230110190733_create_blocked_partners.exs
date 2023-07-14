defmodule SimpleMsBlocklist.Repo.Migrations.CreateBlockedPartners do
  use Ecto.Migration
  import Ecto.SoftDelete.Migration

  def change do
    create_query = "CREATE TYPE reasons AS ENUM ('fraude', 'alerta', 'definitivo', 'fraude_cpf', 'temporario')"
    drop_query = "DROP TYPE reasons"
    execute(create_query, drop_query)

    create table(:blocked_partners) do
      add :cnpj, :string, null: false
      add :reason, :reasons, null: false
      add :partner_id, :integer, null: false
      add :note, :text
      add :expiration_date, :utc_datetime

      timestamps()
      soft_delete_columns()
    end

    create unique_index(:blocked_partners, [:cnpj], name: :cnpj)
  end
end
