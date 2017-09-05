defmodule Extra.AuthorizationTest do
  use Extra.ModelCase, async: true
  alias Extra.Authorization


  describe ".changeset/2" do
    test "with valid attributes" do
      changeset =
        %Authorization{}
        |> Authorization.changeset(params_for(:authorization))

      assert changeset.valid?
    end

    test "with invalid attributes" do
      errors = errors_on(%Authorization{})
      assert {:token, "can't be blank"} in errors
      assert {:secret, "can't be blank"} in errors
    end
  end

  describe ".update_changeset/2" do
    test "with valid attributes" do
      authorization = insert(:authorization)
      now = DateTime.utc_now()

      params = %{
        token: "a different token",
        secret: "a new secret",
        refresh_token: "refreshing this token",
        expires_at: 12_345_678
      }

      {:ok, next_auth} =
        authorization
        |> Authorization.changeset(params)
        |> Repo.update()

      assert next_auth.token == params.token
      assert next_auth.secret == params.secret
      assert next_auth.refresh_token == params.refresh_token
      assert next_auth.expires_at == params.expires_at
      assert :gt = DateTime.compare(next_auth.updated_at, now)
    end
  end
end
