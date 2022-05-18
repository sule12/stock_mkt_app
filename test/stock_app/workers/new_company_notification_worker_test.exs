defmodule StockApp.Workers.NewCompanyNotificationWorkerTest do
  use StockApp.DataCase, async: true
  use Oban.Testing, repo: StockApp.Repo

  import StockApp.Factory
  import Swoosh.TestAssertions
  alias StockApp.Workers.NewCompanyNotificationWorker

  describe "perform" do
    test "should send emails to all subscribers" do
      [first_user | _] = users = insert_list(5, :user)
      [category | _] = categories = insert_pair(:category)

      Enum.each(categories, fn cat ->
        insert(:company, category: cat)
      end)

      Enum.each(users, fn user ->
        insert(:user_subscription, user: user, category: insert(:category))
      end)

      company = insert(:company, category: category)
      insert(:user_subscription, user: first_user, category: category)

      assert :ok ==
               perform_job(NewCompanyNotificationWorker, %{
                 id: company.id,
                 category_id: category.id,
                 name: company.name
               })

      email = StockApp.Email.new_company_notification_email(first_user, company)
      assert_email_sent(email)
    end
  end
end
