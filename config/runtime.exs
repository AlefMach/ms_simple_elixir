import Config

# Configures Guardian Auth
config :simple_ms_blocklist, SimpleMsBlocklistWeb.Auth.Guardian,
  issuer: "simple_ms_blocklist",
  ttl: {3, :days},
  secret_key: System.get_env("GUARDIAN_SECRET_KEY", "")

# Configures Logger
config :logger,
  truncate: :infinity,
  level: String.to_atom(System.get_env("LOGGER_LEVEL", "info"))

if config_env() == :prod do
  # Configures Database
  maybe_ipv6 = []

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

  config :simple_ms_blocklist, SimpleMsBlocklistWeb.Endpoint,
    http: [port: System.get_env("PORT") || 4000],
    url: [host: "localhost"],
    secret_key_base: System.get_env("SECRET_KEY_BASE", "M7ulw7OtJEG3eIfVWSK7wX2qVqcwx2Vu")
end
