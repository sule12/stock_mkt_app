defmodule StockApp.Repo do
  use Ecto.Repo,
    otp_app: :stock_app,
    adapter: Ecto.Adapters.Postgres
end
