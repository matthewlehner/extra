defmodule Extra.Schema.Resolvers.UserResolverTest do
  use Extra.ModelCase, async: true

  alias Extra.User
  alias Extra.Schema.Resolvers.UserResolver
  import Comeonin.Bcrypt, only: [hashpwsalt: 1]

  setup do
    pass = "hi"
    user = insert(:user, password: pass, password_hash: hashpwsalt(pass))
    {:ok, user: user}
  end

  describe ".update_password/2" do
    test "it updates the password", %{user: user} do
      params = %{input: %{current: user.password, new: "new password"}}
      context = %{context: %{current_user: user}}
      assert {:ok, %User{}} = UserResolver.update_password(params, context)
    end
  end

  describe ".update/2" do
    test "it updates the user's info", %{user: user} do
      params = %{input: %{email: "hi@hello.com", timezone: "Canada/Pacific"}}
      context = %{context: %{current_user: user}}
      assert {:ok, %{email: "hi@hello.com", timezone: "Canada/Pacific"}} =
        UserResolver.update(params, context)
    end

    test "it errors intelligently", %{user: user} do
      params = %{input: %{email: "hi", timezone: "Lalaland"}}
      context = %{context: %{current_user: user}}
      assert {:error, %{email: ["has invalid format"], timezone: ["is invalid"]}} =
        UserResolver.update(params, context)
    end
  end
end
