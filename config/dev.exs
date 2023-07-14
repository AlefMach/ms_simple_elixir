import Config

# Configure your database
config :simple_ms_blocklist, SimpleMsBlocklist.Repo,
  username: "admin",
  password: "admin",
  hostname: "db",
  database: "simple_ms_blocklist",
  show_sensitive_data_on_connection_error: true,
  pool_size: 10

config :simple_ms_blocklist, SimpleMsBlocklistWeb.Endpoint,
  http: [port: 4000],
  check_origin: false,
  code_reloader: true,
  debug_errors: true,
  secret_key_base: "0UAJuO1/nkv4s0PYaT3XxvMdGLmpL/ac7RLjnkJqJtBZ9TBnTZLT/F3BB3Iaepib",
  watchers: []

# Do not include metadata nor timestamps in development logs
config :logger, :console,
  format: {ExCommons.Log.CustomFormatter, :format},
  metadata: :all

# Set a higher stacktrace during development. Avoid configuring such
# in production as building large stacktraces may be expensive.
config :phoenix, :stacktrace_depth, 20

# Initialize plugs at runtime for faster development compilation
config :phoenix, :plug_init_mode, :runtime

config :simple_ms_blocklist, SimpleMsBlocklistWeb.PromEx,
  disabled: true,
  grafana: :disabled

config :simple_ms_blocklist, SimpleMsBlocklist.Tracer,
  service: :simple_ms_blocklist,
  disabled?: true,
  env: "local"

config :simple_ms_blocklist, :datadog,
  host: "localhost",
  port: 8126,
  batch_size: 10,
  sync_threshold: 100

if File.exists?("config/dev.secret.exs"), do: import_config("dev.secret.exs")
