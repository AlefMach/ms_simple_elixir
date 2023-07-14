defmodule SimpleMsBlocklistWeb.Auth.Pipeline do
  @moduledoc """
  Pipeline para autenticação de requisições
  """

  use Guardian.Plug.Pipeline,
    otp_app: :simple_ms_blocklist,
    module: SimpleMsBlocklistWeb.Auth.Guardian,
    error_handler: SimpleMsBlocklistWeb.Auth.ErrorHandler

  plug(Guardian.Plug.VerifyHeader)
  plug(Guardian.Plug.EnsureAuthenticated)
  plug(Guardian.Plug.LoadResource)
end
