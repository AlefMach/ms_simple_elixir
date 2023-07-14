defmodule SimpleMsBlocklist.Repo do
  use Ecto.Repo,
    otp_app: :simple_ms_blocklist,
    adapter: Ecto.Adapters.Postgres

  use Ecto.SoftDelete.Repo
end
