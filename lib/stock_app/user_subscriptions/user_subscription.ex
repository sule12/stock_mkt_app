defmodule StockApp.UserSubscriptions.UserSubscription do
  use Ecto.Schema
  import Ecto.Changeset

  alias StockApp.Users.User
  alias StockApp.Categories.Category

  schema "user_subscriptions" do
    belongs_to :user, User
    belongs_to :category, Category

    timestamps()
  end

  @doc false
  def changeset(user_subscription, attrs) do
    user_subscription
    |> cast(attrs, [:user_id, :category_id])
    |> validate_required([:user_id, :category_id])
    |> foreign_key_constraint(:user_id)
    |> foreign_key_constraint(:category_id)
  end
end
