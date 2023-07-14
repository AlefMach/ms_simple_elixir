defmodule SimpleMsBlocklistWeb.HealthCheckController do
  use SimpleMsBlocklistWeb, :controller
  alias SimpleMsBlocklist.UseCases.HealthCheck

  action_fallback(SimpleMsBlocklist.FallbackController)

  @spec check(any, map) :: map
  def check(conn, _params) do
    with {:ok, status} <- HealthCheck.check() do
      json(conn, status)
    end
  end
end
