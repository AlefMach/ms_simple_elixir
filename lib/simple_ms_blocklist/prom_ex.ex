defmodule SimpleMsBlocklistWeb.PromEx do
  @moduledoc """
  Configuração da biblioteca [PromEx](https://hexdocs.pm/prom_ex/) para
  envio de métricas para ao [Prometheus](https://prometheus.io/).
  """

  use PromEx, otp_app: :simple_ms_blocklist

  alias PromEx.Plugins

  @impl PromEx
  def plugins do
    [
      Plugins.Application,
      Plugins.Beam,
      {Plugins.Phoenix, router: SimpleMsBlocklistWeb.Router},
      Plugins.Ecto
    ]
  end

  @impl PromEx
  def dashboard_assigns do
    [
      datasource_id: Application.get_env(:simple_ms_blocklist, :grafana)[:datasource]
    ]
  end

  @impl PromEx
  def dashboards do
    [
      {:prom_ex, "application.json"},
      {:prom_ex, "beam.json"},
      {:prom_ex, "phoenix.json"},
      {:prom_ex, "ecto.json"}
    ]
  end
end
