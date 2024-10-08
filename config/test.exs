use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :extra, ExtraWeb.Endpoint,
  http: [port: 4001],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

# Configure your database
config :extra, Extra.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: System.get_env("DATABASE_POSTGRESQL_USERNAME") || "matthew",
  password: System.get_env("DATABASE_POSTGRESQL_PASSWORD") || nil,
  database: "extra_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox
