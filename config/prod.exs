import Config

config :logger_json, :backend,
  formatter: LoggerJSON.Formatters.DatadogLogger,
  metadata: :all

config :logger,
  level: :info,
  backends: [LoggerJSON, Sentry.LoggerBackend]

config :swoosh, local: false
config :swoosh, serve_mailbox: false
