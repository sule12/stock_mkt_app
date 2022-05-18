defmodule StockAppWeb.Api.V1.CompaniesControllerTest do
  use StockAppWeb.ConnCase

  import StockApp.Factory

  describe "/companies" do
    test "returns an empty list when there is no company", %{conn: conn} do
      conn = get(conn, Routes.api_v1_companies_path(conn, :index))
      assert response = json_response(conn, 200)
      assert response["data"]["companies"] == []
    end

    test "returns a list of companies when there are compnies", %{conn: conn} do
      [company | _] = insert_list(30, :company)
      conn = get(conn, Routes.api_v1_companies_path(conn, :index))
      assert response = json_response(conn, 200)
      companies = response["data"]["companies"]
      refute companies == []
      assert Enum.any?(companies, fn item -> item["name"] == company.name end)
    end
  end
end
