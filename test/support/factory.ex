defmodule StockApp.Factory do
  use ExMachina.Ecto, repo: StockApp.Repo

  alias StockApp.Users.User
  alias StockApp.Categories.Category
  alias StockApp.Companies.Company
  alias StockApp.UserSubscriptions.UserSubscription

  def user_factory do
    %User{
      firstname: "John",
      lastname: "Doe",
      email: sequence(:email, &"email-#{&1}@example.com")
    }
  end

  def category_factory do
    %Category{
      name: sequence(:category_name, &"category-#{&1}")
    }
  end

  def company_factory do
    %Company{
      name: sequence(:category_name, &"company-#{&1}"),
      category: build(:category),
      stock_price: 100,
      stock_symbol: sequence(:stock_symbol, &"AAPL-#{&1}"),
      description: sequence(:description, &"Random description #{&1}")
    }
  end

  @spec user_subscription_factory :: %StockApp.UserSubscriptions.UserSubscription{
          __meta__: Ecto.Schema.Metadata.t(),
          category: any,
          category_id: nil,
          id: nil,
          inserted_at: nil,
          updated_at: nil,
          user: any,
          user_id: nil
        }
  def user_subscription_factory do
    %UserSubscription{
      user: build(:user),
      category: build(:category)
    }
  end
end
