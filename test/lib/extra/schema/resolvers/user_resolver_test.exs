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
      params = %{password: %{current: user.password, new: "new password"}}
      context = %{context: %{current_user: user}}
      assert {:ok, %User{}} = UserResolver.update_password(params, context)
    end
  end
end
