defmodule Extra.AuthTokenTest do
  use Extra.ModelCase, async: true

  alias Extra.AuthToken

  @valid_attrs %{token: "some content", uid: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = AuthToken.changeset(%AuthToken{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = AuthToken.changeset(%AuthToken{}, @invalid_attrs)
    refute changeset.valid?
  end
end
