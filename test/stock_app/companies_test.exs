defmodule StockApp.CompaniesTest do
  use StockApp.DataCase
  use Oban.Testing, repo: StockApp.Repo

  import StockApp.Factory

  alias StockApp.Companies
  alias StockApp.Workers.NewCompanyNotificationWorker

  describe "companies" do
    alias StockApp.Companies.Company

    @invalid_attrs %{name: nil, stock_symbol: nil}

    test "list_companies/0 returns all companies" do
      %Company{id: id} = insert(:company)
      [company] = Companies.list_companies()
      assert company.id == id
    end

    test "get_company!/1 returns the company with given id" do
      %{id: id, name: name, category_id: category_id} = insert(:company)

      assert %Company{id: ^id, name: ^name, category_id: ^category_id} =
               Companies.get_company!(id)
    end

    test "create_company/1 with valid data creates a company" do
      valid_attrs = params_for(:company, category: insert(:category))

      assert {:ok, %Company{id: id, category_id: category_id} = company} =
               Companies.create_company(valid_attrs)

      assert company.name == valid_attrs.name
      assert company.stock_symbol == valid_attrs.stock_symbol

      assert [%{args: %{"id" => ^id, "category_id" => ^category_id}}] =
               all_enqueued(worker: NewCompanyNotificationWorker, queue: "events")
    end

    test "create_company/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Companies.create_company(@invalid_attrs)
    end

    test "update_company/2 with valid data updates the company" do
      company = insert(:company)
      update_attrs = params_for(:company)

      assert {:ok, %Company{} = company} = Companies.update_company(company, update_attrs)
      assert company.name == update_attrs.name
      assert company.stock_symbol == update_attrs.stock_symbol
    end

    test "update_company/2 with invalid data returns error changeset" do
      company = insert(:company)
      %{id: id, name: name, category_id: category_id, updated_at: updated_at} = company

      assert {:error, %Ecto.Changeset{}} = Companies.update_company(company, @invalid_attrs)

      assert %Company{id: ^id, name: ^name, category_id: ^category_id, updated_at: ^updated_at} =
               Companies.get_company!(id)
    end

    test "delete_company/1 deletes the company" do
      company = insert(:company)
      assert {:ok, %Company{}} = Companies.delete_company(company)
      assert_raise Ecto.NoResultsError, fn -> Companies.get_company!(company.id) end
    end

    test "change_company/1 returns a company changeset" do
      company = insert(:company)
      assert %Ecto.Changeset{} = Companies.change_company(company)
    end
  end
end
