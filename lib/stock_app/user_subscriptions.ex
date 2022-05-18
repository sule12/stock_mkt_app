defmodule StockApp.UserSubscriptions do
  @moduledoc """
  The UserSubscriptions context.
  """

  import Ecto.Query, warn: false
  alias StockApp.Repo

  alias StockApp.UserSubscriptions.UserSubscription

  @doc """
  Returns the list of user_subscriptions.

  ## Examples

      iex> list_user_subscriptions()
      [%UserSubscription{}, ...]

  """
  def list_user_subscriptions do
    Repo.all(UserSubscription)
  end

  @doc """
  Gets a single user_subscription.

  Raises `Ecto.NoResultsError` if the User subscription does not exist.

  ## Examples

      iex> get_user_subscription!(123)
      %UserSubscription{}

      iex> get_user_subscription!(456)
      ** (Ecto.NoResultsError)

  """
  def get_user_subscription!(id), do: Repo.get!(UserSubscription, id)

  def get_subscribers_by_category(category_id) do
    UserSubscription
    |> where(category_id: ^category_id)
    |> Repo.all()
    |> Repo.preload(:user)
  end

  @doc """
  Creates a user_subscription.

  ## Examples

      iex> create_user_subscription(%{field: value})
      {:ok, %UserSubscription{}}

      iex> create_user_subscription(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_user_subscription(attrs \\ %{}) do
    %UserSubscription{}
    |> UserSubscription.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a user_subscription.

  ## Examples

      iex> update_user_subscription(user_subscription, %{field: new_value})
      {:ok, %UserSubscription{}}

      iex> update_user_subscription(user_subscription, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_user_subscription(%UserSubscription{} = user_subscription, attrs) do
    user_subscription
    |> UserSubscription.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a user_subscription.

  ## Examples

      iex> delete_user_subscription(user_subscription)
      {:ok, %UserSubscription{}}

      iex> delete_user_subscription(user_subscription)
      {:error, %Ecto.Changeset{}}

  """
  def delete_user_subscription(%UserSubscription{} = user_subscription) do
    Repo.delete(user_subscription)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking user_subscription changes.

  ## Examples

      iex> change_user_subscription(user_subscription)
      %Ecto.Changeset{data: %UserSubscription{}}

  """
  def change_user_subscription(%UserSubscription{} = user_subscription, attrs \\ %{}) do
    UserSubscription.changeset(user_subscription, attrs)
  end
end
