defmodule RocketpayWeb.UsersViewTest do
  use RocketpayWeb.ConnCase

  import Phoenix.View

  alias Rocketpay.{Account, User}
  alias RocketpayWeb.UsersView

  test "renders create.json" do
    params = %{
      name: "Hamilton12",
      password: "1234567",
      nickname: "mirststs",
      email: "hamilton@hamilton.com",
      age: 24
    }

    {:ok, %User{id: user_id, account: %Account{id: account_id}} = user} = Rocketpay.create_user(params)

    response = render(UsersView, "create.json", user: user)

    expected_response = %{
      message: "User created",
      user: %{
        account: %{
          balance: Decimal.new("0.00"),
          id: account_id
        },
        id: user_id,
        name: "Hamilton12"
        nickname: "mirststs"
      }
    }

    assert expected_response == response
  end
end
