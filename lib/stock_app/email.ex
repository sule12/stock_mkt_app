defmodule StockApp.Email do
  import Swoosh.Email

  def new_company_notification_email(user, company) do
    new()
    |> from({"Dr B Banner", "info@bamboo.io"})
    |> subject("New Company notification")
    |> html_body("""
    <h1>Hello #{user.firstname}</h1>
    <br />
    <p>#{company.name} has been added to our portfolio</p>

    <p> #{company.description} </p>


    <strong>Symbol: </strong> #{company.stock_symbol} <br />
    <strong>Price: </strong> #{company.stock_price} <br />



    """)
    |> text_body("Hello #{user.firstname}\n")
  end
end
