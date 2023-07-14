defmodule SimpleMsBlocklistWeb.Router do
  use SimpleMsBlocklistWeb, :router

  pipeline :api do
    plug(:accepts, ["json"])
  end

  pipeline :browser do
    plug(:accepts, ["html"])
    plug(:fetch_session)
    plug(:protect_from_forgery)
  end

  pipeline :api_swagger do
    plug(:accepts, ["json"])
    plug(OpenApiSpex.Plug.PutApiSpec, module: SimpleMsBlocklistWeb.Swagger.ApiSpec)
  end

  scope "/blocklist", SimpleMsBlocklistWeb do
    pipe_through([:api])

    get("/:cnpj", BlocklistController, :handle)
  end

  scope "/" do
    pipe_through(:browser)

    get("/health-check", SimpleMsBlocklistWeb.HealthCheckController, :check)
    get("/swaggerui", OpenApiSpex.Plug.SwaggerUI, path: "/openapi")
  end

  scope "/openapi" do
    pipe_through(:api_swagger)

    get("/", OpenApiSpex.Plug.RenderSpec, [])
  end

  # Enables LiveDashboard only for development
  #
  # If you want to use the LiveDashboard in production, you should put
  # it behind authentication and allow only admins to access it.
  # If your application does not have an admins-only section yet,
  # you can use Plug.BasicAuth to set up some basic authentication
  # as long as you are also using SSL (which you should anyway).
  if Mix.env() in [:dev, :test] do
    import Phoenix.LiveDashboard.Router

    scope "/" do
      pipe_through([:fetch_session, :protect_from_forgery])

      live_dashboard("/dashboard", metrics: SimpleMsBlocklistWeb.Telemetry)
    end
  end
end
