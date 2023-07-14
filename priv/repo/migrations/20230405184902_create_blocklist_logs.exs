defmodule SimpleMsBlocklist.Repo.Migrations.CreateBlocklistLogs do
  use Ecto.Migration

  def change do
    create table(:blocklist_logs) do
      add :action, :string
      add :reason, :string
      add :responsible_area, :string

      timestamps()
    end
  end
end
