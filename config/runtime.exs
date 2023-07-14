import Config

# Configures Guardian Auth
config :simple_ms_blocklist, SimpleMsBlocklistWeb.Auth.Guardian,
  issuer: "simple_ms_blocklist",
  ttl: {3, :days},
  secret_key: System.get_env("GUARDIAN_SECRET_KEY")

# Configures Logger
config :logger,
  truncate: :infinity,
  level: String.to_atom(System.get_env("LOGGER_LEVEL", "info"))

# Configures Sentry
config :sentry,
  dsn: System.get_env("SENTRY_DNS"),
  environment_name: System.get_env("SENTRY_ENV"),
  enable_source_code_context: true,
  root_source_code_path: File.cwd!(),
  tags: %{
    env: System.get_env("SENTRY_ENV")
  },
  included_environments: ["stg", "prod"]

# Configures Sentry
config :simple_ms_blocklist, :feature_flag,
  secret_key: System.get_env("LAUNCH_DARKLY_SECRET_KEY", "123")

if config_env() == :prod do
  # Configures Database
  maybe_ipv6 = if System.get_env("ECTO_IPV6"), do: [:inet6], else: []

  config :simple_ms_blocklist, SimpleMsBlocklist.Repo,
    username: System.fetch_env!("DATABASE_USERNAME"),
    password: System.fetch_env!("DATABASE_PASSWORD"),
    database: System.fetch_env!("DATABASE_NAME"),
    hostname: System.fetch_env!("DATABASE_HOSTNAME"),
    port: System.get_env("DATABASE_PORT", "5432"),
    show_sensitive_data_on_connection_error:
      System.get_env("DATABASE_SHOW_SENSITIVE_DATA", "false") == "true",
    pool_size: String.to_integer(System.get_env("POOL_SIZE", "10")),
    timeout: 300_000,
    socket_options: maybe_ipv6

  config :simple_ms_blocklist, SimpleMsBlocklistWeb.Endpoint, server: true

  protocol =
    case System.get_env("ENABLE_HTTPS") do
      "true" -> [scheme: "https", port: 443]
      _ -> [scheme: "http", port: 80]
    end

  config :simple_ms_blocklist, SimpleMsBlocklistWeb.Endpoint,
    http: [port: System.get_env("PORT") || 80],
    url: [host: System.get_env("simple_ms_blocklist_WEB")] ++ protocol,
    secret_key_base: System.fetch_env!("SECRET_KEY_BASE")

  config :simple_ms_blocklist, SimpleMsBlocklist.Tracer,
    service: :simple_ms_blocklist,
    adapter: SpandexDatadog.Adapter,
    disabled?: String.to_existing_atom(System.get_env("DATADOG_DISABLED") || "true"),
    env: System.get_env("DATADOG_ENV")

  config :simple_ms_blocklist, :datadog,
    host: System.get_env("DATADOG_HOST"),
    port: System.get_env("DATADOG_PORT"),
    batch_size: System.get_env("DATADOG_BATCH_SIZE"),
    sync_threshold: System.get_env("DATADOG_SYNC_THRESHOLD")

  config :simple_ms_blocklist, SimpleMsBlocklistWeb.PromEx,
    metrics_server: [port: String.to_integer(System.get_env("PROMEX_PORT", "4003"))],
    grafana: [
      datasource: System.get_env("GRAFANA_DATASOURCE"),
      host: System.get_env("GRAFANA_HOST"),
      auth_token: System.get_env("GRAFANA_TOKEN"),
      folder_name: System.get_env("GRAFANA_FOLDER"),
      upload_dashboards_on_start: false
    ]
end
