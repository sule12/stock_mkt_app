defmodule StockApp.Companies.Company do
  use Ecto.Schema
  import Ecto.Changeset

  alias StockApp.Categories.Category

  schema "companies" do
    field :name, :string
    field :stock_symbol, :string
    field :stock_price, :float
    field :description, :string
    belongs_to :category, Category

    timestamps()
  end

  @doc false
  def changeset(company, attrs) do
    company
    |> cast(attrs, [:name, :stock_symbol, :stock_price, :description, :category_id])
    |> validate_required([:name, :stock_symbol, :stock_price, :category_id])
    |> unique_constraint(:stock_symbol)
    |> foreign_key_constraint(:category_id)
  end
end
