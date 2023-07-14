defmodule SimpleMsBlocklist.Schemas.In.BlocklistLog do
  @moduledoc false

  use Ecto.Schema
  import Ecto.Changeset

  schema "blocklist_logs" do
    field(:action, :string)
    field(:reason, :string)
    field(:responsible_area, :string)

    timestamps()
  end

  @doc false
  def changeset(blocklist_log, attrs) do
    blocklist_log
    |> cast(attrs, [:action, :reason, :responsible_area])
    |> validate_required([:action, :reason, :responsible_area])
  end
end
