import Config

# Configure your database
#
# The MIX_TEST_PARTITION environment variable can be used
# to provide built-in test partitioning in CI environment.
# Run `mix help test` for more information.
config :hello_team, HelloTeam.Repo,
  username: System.get_env("HELLO_TEAM__PGUSER"),
  password: System.get_env("HELLO_TEAM__PGPASSWORD"),
  hostname: System.get_env("HELLO_TEAM__PGHOST"),
  database: "#{System.get_env("HELLO_TEAM__PGDATABASE")}#{System.get_env("MIX_TEST_PARTITION")}",
  pool: Ecto.Adapters.SQL.Sandbox,
  pool_size: System.schedulers_online() * 2

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :hello_team_web, HelloTeamWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "FEg9DVYsIZRqhNNrWdfB9Jt/0dPzhC40AAAJk0WixvHaXoQ4EqEzSMRh9EAF0oTT",
  server: false

# Print only warnings and errors during test
config :logger, level: :warning

# In test we don't send emails
config :hello_team, HelloTeam.Mailer, adapter: Swoosh.Adapters.Test

# Disable swoosh api client as it is only required for production adapters
config :swoosh, :api_client, false

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime

# Enable helpful, but potentially expensive runtime checks
config :phoenix_live_view,
  enable_expensive_runtime_checks: true

config :cabbage, features: "test/features/"
