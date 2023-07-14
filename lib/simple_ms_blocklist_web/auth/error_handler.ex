defmodule SimpleMsBlocklistWeb.Auth.ErrorHandler do
  @moduledoc """
  Módulo para tratamento de erros de autenticação
  """

  import Plug.Conn, only: [send_resp: 3]

  @behaviour Guardian.Plug.ErrorHandler

  @impl Guardian.Plug.ErrorHandler
  @spec auth_error(Plug.Conn.t(), {atom, String.t()}, map) :: Plug.Conn.t()
  def auth_error(conn, {type, _reason}, _opts) do
    body = Jason.encode!(%{message: to_string(type)})

    send_resp(conn, :unauthorized, body)
  end
end
