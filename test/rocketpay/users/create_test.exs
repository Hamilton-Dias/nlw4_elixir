defmodule Rocketpay.Users.CreateTest do
  use Rocketpay.DataCase

  alias Rocketpay.User
  alias Rocketpay.Users.Create

  describe "call/1" do
    test "when all params are valid, returns an user" do
      params = %{
        name: "Hamilton12",
        password: "1234567",
        nickname: "mirststs",
        email: "hamilton@hamilton.com",
        age: 24
      }

      {:ok, %User{id: user_id}} = Create.call(params)
      user = Repo.get(User, user_id)

      assert %User{name: "Rafael", age: 24, id: ^user_id} = user
    end

    test "when all params are invalid params, returns an error" do
      params = %{
        name: "Hamilton12",
        password: "",
        nickname: "mirststs",
        email: "hamilton@hamilton.com",
        age: 10
      }

      {:error, changeset} = Create.call(params)

      expected_response = %{
        age: ["must be greater than or equal to 18"],
        password: ["can't be blank"]
      }

      assert errors_on(changeset) == expected_response
    end
  end
end
