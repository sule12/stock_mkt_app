defmodule StockApp.Repo.Migrations.CreateCompanies do
  use Ecto.Migration

  def change do
    create table(:companies) do
      add :name, :string
      add :stock_symbol, :string
      add :stock_price, :float
      add :description, :string
      add :category_id, references(:categories, on_delete: :nothing)

      timestamps()
    end

    create unique_index(:companies, [:stock_symbol])
    create index(:companies, [:category_id])
  end
end
