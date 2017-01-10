defmodule Extra.AuthorizationTest do
  use Extra.ModelCase

  alias Extra.Authorization

  @valid_attrs params_for(:authorization)
  @invalid_attrs %{}

  describe "Authorization.changeset" do
    test "changeset with valid attributes" do
      changeset = Authorization.changeset(%Authorization{}, @valid_attrs)
      assert changeset.valid?
    end

    test "changeset with invalid attributes" do
      changeset = Authorization.changeset(%Authorization{}, @invalid_attrs)
      refute changeset.valid?
    end

    test "with duplicate account" do
      auth1 = insert(:authorization)
      auth2_params = Map.merge(params_for(:authorization), %{uid: auth1.uid})

      assert {:error, auth2} = Authorization.changeset(%Authorization{}, auth2_params)
                               |> Repo.insert()
      assert {:uid, "has already been taken"} in errors_on(auth2)
    end
  end
end
