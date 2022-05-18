defmodule StockApp.UserSubscriptionsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `StockApp.UserSubscriptions` context.
  """

  @doc """
  Generate a user_subscription.
  """
  def user_subscription_fixture(attrs \\ %{}) do
    {:ok, user_subscription} =
      attrs
      |> Enum.into(%{

      })
      |> StockApp.UserSubscriptions.create_user_subscription()

    user_subscription
  end
end
