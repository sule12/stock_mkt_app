defmodule StockAppWeb.Api.V1.CompaniesController do
  use StockAppWeb, :controller
  alias StockApp.Companies

  def index(conn, _params) do
    companies = Companies.list_companies()

    render(conn, "companies.json", %{companies: companies})
  end
end
