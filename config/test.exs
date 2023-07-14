import Config

config :simple_ms_blocklist, SimpleMsBlocklist.Repo,
  username: "admin",
  password: "admin",
  hostname: "db",
  database: "simple_ms_blocklist_test#{System.get_env("MIX_TEST_PARTITION")}",
  pool: Ecto.Adapters.SQL.Sandbox,
  pool_size: 10

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :simple_ms_blocklist, SimpleMsBlocklistWeb.Endpoint,
  http: [port: 4002],
  secret_key_base: "0oyDXOBIWkmrPCyJcrwTHzHkxTalzsvO55rBOyr2RYw3KPOror0C+37dmV+zRzgX",
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime

config :simple_ms_blocklist, SimpleMsBlocklistWeb.PromEx,
  disabled: true,
  grafana: :disabled

config :simple_ms_blocklist, SimpleMsBlocklist.Tracer,
  service: :simple_ms_blocklist,
  disabled?: true,
  env: "test"

config :messaging,
  broker_module: Broadway.DummyProducer,
  transcoder: Messaging.Transcoder.Noop

config :kafka_ex,
  disable_default_worker: true

config :grpc, start_server: false

try do
  import_config "local.secret.exs"
rescue
  _ -> nil
end
