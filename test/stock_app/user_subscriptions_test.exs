defmodule StockApp.UserSubscriptionsTest do
  use StockApp.DataCase

  import StockApp.Factory

  alias StockApp.UserSubscriptions

  describe "user_subscriptions" do
    alias StockApp.UserSubscriptions.UserSubscription

    @invalid_attrs %{user_id: nil, category_id: nil}

    test "list_user_subscriptions/0 returns all user_subscriptions" do
      %UserSubscription{id: id, category_id: category_id, user_id: user_id} =
        insert(:user_subscription)

      assert [
               %UserSubscription{id: ^id, category_id: ^category_id, user_id: ^user_id}
             ] = UserSubscriptions.list_user_subscriptions()
    end

    test "get_user_subscription!/1 returns the user_subscription with given id" do
      %UserSubscription{id: id, category_id: category_id, user_id: user_id} =
        insert(:user_subscription)

      assert %UserSubscription{id: ^id, user_id: ^user_id, category_id: ^category_id} =
               UserSubscriptions.get_user_subscription!(id)
    end

    test "create_user_subscription/1 with valid data creates a user_subscription" do
      %{id: user_id} = user = insert(:user)
      %{id: category_id} = category = insert(:category)
      valid_attrs = params_for(:user_subscription, user: user, category: category)

      assert {:ok, %UserSubscription{user_id: ^user_id, category_id: ^category_id}} =
               UserSubscriptions.create_user_subscription(valid_attrs)
    end

    test "create_user_subscription/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} =
               UserSubscriptions.create_user_subscription(@invalid_attrs)
    end

    test "update_user_subscription/2 with valid data updates the user_subscription" do
      user_subscription = insert(:user_subscription)
      %{id: category_id} = insert(:category)
      %{id: user_id} = insert(:user)
      update_attrs = %{user_id: user_id, category_id: category_id}

      assert {:ok, %UserSubscription{user_id: ^user_id, category_id: ^category_id}} =
               UserSubscriptions.update_user_subscription(user_subscription, update_attrs)
    end

    test "update_user_subscription/2 with invalid data returns error changeset" do
      %UserSubscription{
        id: id,
        user_id: user_id,
        category_id: category_id,
        updated_at: updated_at
      } = user_subscription = insert(:user_subscription)

      assert {:error, %Ecto.Changeset{}} =
               UserSubscriptions.update_user_subscription(user_subscription, @invalid_attrs)

      assert %UserSubscription{
               user_id: ^user_id,
               category_id: ^category_id,
               updated_at: ^updated_at
             } = UserSubscriptions.get_user_subscription!(id)
    end

    test "delete_user_subscription/1 deletes the user_subscription" do
      user_subscription = insert(:user_subscription)

      assert {:ok, %UserSubscription{}} =
               UserSubscriptions.delete_user_subscription(user_subscription)

      assert_raise Ecto.NoResultsError, fn ->
        UserSubscriptions.get_user_subscription!(user_subscription.id)
      end
    end

    test "change_user_subscription/1 returns a user_subscription changeset" do
      user_subscription = insert(:user_subscription)
      assert %Ecto.Changeset{} = UserSubscriptions.change_user_subscription(user_subscription)
    end
  end
end
