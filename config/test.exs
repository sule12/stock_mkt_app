import Config

# Configure your database
#
# The MIX_TEST_PARTITION environment variable can be used
# to provide built-in test partitioning in CI environment.
# Run `mix help test` for more information.
config :stock_app, StockApp.Repo,
  username: "postgres",
  password: "postgres",
  hostname: "localhost",
  database: "stock_app_test#{System.get_env("MIX_TEST_PARTITION")}",
  pool: Ecto.Adapters.SQL.Sandbox,
  pool_size: 10

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :stock_app, StockAppWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "DKIL9ufLFsPtpN0/Dr+ip16FDP6mFMcNxU600PQHBbgty1BiwSLn9syc3j32r/xT",
  server: false

# In test we don't send emails.
config :stock_app, StockApp.Mailer, adapter: Swoosh.Adapters.Test

# Print only warnings and errors during test
config :logger, level: :warn

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime

config :stock_app, Oban, testing: :manual
