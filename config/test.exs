use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :feelingsmotron, FeelingsmotronWeb.Endpoint,
  http: [port: 4001],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

# Configure your database
config :feelingsmotron, Feelingsmotron.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: System.get_env("PG_USER"),
  password: System.get_env("PG_PASSWORD"),
  database: "feelingsmotron_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox
