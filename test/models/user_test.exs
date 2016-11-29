defmodule Extra.UserTest do
  use Extra.ModelCase

  alias Extra.User

  @valid_attrs %{email: "hi@theretime.com"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = User.changeset(%User{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with blank email" do
    assert {:email, "can't be blank"} in errors_on(%User{}, @invalid_attrs)
  end

  test "changeset with improper" do
    assert {:email, "has invalid format"} in errors_on(%User{}, %{email: "hi"})
  end

  test "registration_changeset with valid attributes" do
    changeset = User.registration_changeset(%User{}, %{email: "hi@there.com", password: "its a password!"})
    assert changeset.valid?
  end

  test "registration_changeset with invalid attributes" do
    errors = errors_on(User.registration_changeset(%User{}))
    assert {:email, "can't be blank"} in errors
    assert {:password, "can't be blank"} in errors
  end

  test "registration_with short password" do
    errors = errors_on(User.registration_changeset(%User{}, %{password: "hi"}))
    assert {:password, "should be at least 8 character(s)"} in errors
  end
end
