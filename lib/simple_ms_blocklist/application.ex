defmodule SimpleMsBlocklist.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false
  use Application

  @impl Application
  @spec start(any, any) :: {:error, any} | {:ok, pid}
  def start(_type, _args) do
    children = [
      SimpleMsBlocklistWeb.PromEx,
      SimpleMsBlocklist.Repo,
      SimpleMsBlocklistWeb.Telemetry,
      {Phoenix.PubSub, name: SimpleMsBlocklist.PubSub},
      SimpleMsBlocklistWeb.Endpoint
    ]

    SpandexPhoenix.Telemetry.install()

    opts = [strategy: :one_for_one, name: SimpleMsBlocklist.Supervisor]

    :ok =
      :telemetry.attach(
        "spandex-query-tracer",
        [:simple_ms_blocklist, :repo, :query],
        &SpandexEcto.TelemetryAdapter.handle_event/4,
        nil
      )

    Supervisor.start_link(children, opts)
  end
end
