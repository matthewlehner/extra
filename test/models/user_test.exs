defmodule Extra.UserTest do
  use Extra.ModelCase

  alias Extra.User

  @valid_attrs %{email: "hi@theretime.com"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = User.changeset(%User{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = User.changeset(%User{}, @invalid_attrs)
    refute changeset.valid?
  end

  test "registration_changeset with valid attributes" do
    changeset = %User{email: "hi@there.com"}
                |> User.registration_changeset(%{password: "its a password!"})
    assert changeset.valid?
  end

  test "registration_changeset with invalid attributes" do
    changeset = %User{email: "hi@there.com"}
                |> User.registration_changeset(%{password: "short"})
    refute changeset.valid?
  end
end
