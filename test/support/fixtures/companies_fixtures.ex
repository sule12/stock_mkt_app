defmodule StockApp.CompaniesFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `StockApp.Companies` context.
  """

  @doc """
  Generate a unique company stock_symbol.
  """
  def unique_company_stock_symbol, do: "some stock_symbol#{System.unique_integer([:positive])}"

  @doc """
  Generate a company.
  """
  def company_fixture(attrs \\ %{}) do
    {:ok, company} =
      attrs
      |> Enum.into(%{
        name: "some name",
        stock_symbol: unique_company_stock_symbol()
      })
      |> StockApp.Companies.create_company()

    company
  end
end
