defmodule StockAppWeb.Api.V1.CompaniesView do
  use StockAppWeb, :view

  def render("companies.json", %{companies: companies}) do
    %{
      data: %{
        companies: render_many(companies, __MODULE__, "company.json", as: :company)
      }
    }
  end

  def render("company.json", %{company: company}) do
    %{
      name: company.name,
      id: company.id,
      category_id: company.category_id,
      symbol: company.stock_symbol,
      price: company.stock_price
    }
  end
end
