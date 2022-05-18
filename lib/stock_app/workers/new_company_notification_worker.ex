defmodule StockApp.Workers.NewCompanyNotificationWorker do
  use Oban.Worker, queue: :events

  @impl Oban.Worker
  def perform(%Oban.Job{args: %{"id" => id, "category_id" => category_id}}) do
    company = StockApp.Companies.get_company!(id)
    subscribers = StockApp.UserSubscriptions.get_subscribers_by_category(category_id)

    Enum.each(subscribers, fn subscriber ->
      subscriber.user
      |> StockApp.Email.new_company_notification_email(company)
      |> StockApp.Mailer.deliver()
    end)

    :ok
  end
end
