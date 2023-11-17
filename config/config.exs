import Config

# Configures Database
config :simple_ms_blocklist, repo: SimpleMsBlocklist.Repo

# ---------------------------#
# SimpleMsBlocklistWeb
# ---------------------------#
config :simple_ms_blocklist,
  generators: [context_app: :simple_ms_blocklist, binary_id: true]

# ---------------------------#
# Socket
# ---------------------------#
config :simple_ms_blocklist, :socket, check_origin: false

config :simple_ms_blocklist,
  ecto_repos: [SimpleMsBlocklist.Repo]

config :simple_ms_blocklist, SimpleMsBlocklist.Repo, migration_timestamps: [type: :utc_datetime_usec]

# Configures the endpoint
config :simple_ms_blocklist, SimpleMsBlocklistWeb.Endpoint,
  url: [host: "localhost"],
  render_errors: [view: SimpleMsBlocklistWeb.ErrorView, accepts: ~w(json), layout: false],
  pubsub_server: SimpleMsBlocklist.PubSub,
  live_view: [signing_salt: "5+0LThY3"],
  server: true

# Configures the GraphQL endpoint
config :simple_ms_blocklist, SimpleMsBlocklistWeb.GraphQL.Endpoint,
  url: [host: "localhost"],
  render_errors: [view: SimpleMsBlocklistWeb.ErrorView, accepts: ~w(json), layout: false],
  pubsub_server: SimpleMsBlocklist.PubSub,
  live_view: [signing_salt: "M7ulw7OtJEG3eIfVWSK7wX2qVqcwx2Vu"]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

config :simple_ms_blocklist, adapter: Tesla.Adapter.Hackney

config :simple_ms_blocklist, SimpleMsBlocklist.Tracer,
  service: :simple_ms_blocklist,
  adapter: SpandexDatadog.Adapter,
  disabled?: false,
  env: "local"

config :spandex_ecto, SpandexEcto.EctoLogger,
  service: :simple_ms_blocklist_ecto,
  tracer: SimpleMsBlocklist.Tracer

config :spandex_phoenix, tracer: SimpleMsBlocklist.Tracer

config :simple_ms_blocklist, SimpleMsBlocklistWeb.PromEx,
  disabled: false,
  manual_metrics_start_delay: :no_delay,
  grafana: :disabled,
  metrics_server: :disabled

# Configures gRPC
config :grpc, start_server: true

import_config "#{config_env()}.exs"
