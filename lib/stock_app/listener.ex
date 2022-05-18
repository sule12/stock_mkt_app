defmodule StockApp.Listener do
  use Broadway

  alias Broadway.Message
  alias StockApp.Companies

  def start_link(_opts) do
    Broadway.start_link(__MODULE__,
      name: MyBroadway,
      producer: [
        module:
          {BroadwayRabbitMQ.Producer,
           queue: "stock_queue",
           connection: [
             username: "user",
             password: "password"
           ],
           qos: [
             prefetch_count: 50
           ]},
        concurrency: 1
      ],
      processors: [
        default: [
          concurrency: 50
        ]
      ]
    )
  end

  @impl true
  def handle_message(_, message, _) do
    message
    |> Message.update_data(&persist_notification/1)
  end

  defp persist_notification(data) do
    IO.inspect(data)
    # sample payload
    # {"name": "Bayero", "stock_symbol": "AAPL", "stock_price": 100, "description": "Sample", "category": "Tech"}

    data
    |> Jason.decode!()
    |> Companies.create_company()
    |> IO.inspect()
  end
end
