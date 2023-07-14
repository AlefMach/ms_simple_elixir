defmodule SimpleMsBlocklistWeb.Swagger.ApiSpec do
  @moduledoc false
  alias OpenApiSpex.{Info, OpenApi, Paths, Server}
  alias SimpleMsBlocklistWeb.{Endpoint, Router}
  @behaviour OpenApi

  @impl OpenApi
  def spec do
    # credo:disable-for-lines:29 Credo.Check.Readability.SinglePipe
    %OpenApi{
      servers: [
        Server.from_endpoint(Endpoint)
      ],
      info: %Info{
        title: "SimpleMsBlocklist API",
        version: "V1"
      },
      paths: Paths.from_router(Router)
    }
    |> OpenApiSpex.resolve_schema_modules()
  end
end
