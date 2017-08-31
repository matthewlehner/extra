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

  describe ".get/2" do
    test "returns the user", %{user: user} do
      context = %{context: %{current_user: user}}
      assert {:ok, %User{}} = UserResolver.get(nil, context)
    end
  end

  describe ".update_password/2" do
    test "it updates the password", %{user: user} do
      params = %{input: %{current: user.password, new: "new password"}}
      context = %{context: %{current_user: user}}
      assert {:ok, %{user: %User{}}} = UserResolver.update_password(params, context)
    end

    test "it errors with incorrect password", %{user: user} do
      params = %{input: %{current: "wrong password", new: "new password"}}
      context = %{context: %{current_user: user}}
      assert {:ok, %{user_errors: [%{field: :current, message: "The password provided is incorrect"}]}} = UserResolver.update_password(params, context)
    end
  end

  describe ".update/2" do
    test "it updates the user's info", %{user: user} do
      params = %{input: %{email: "hi@hello.com"}}
      context = %{context: %{current_user: user}}
      assert {:ok, %{email: "hi@hello.com"}} =
        UserResolver.update(params, context)
    end

    test "it errors intelligently", %{user: user} do
      params = %{input: %{email: "hi"}}
      context = %{context: %{current_user: user}}
      assert {:error, %{email: ["has invalid format"]}} =
        UserResolver.update(params, context)
    end
  end
end
