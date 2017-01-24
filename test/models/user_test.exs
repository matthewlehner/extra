defmodule Extra.UserTest do
  use Extra.ModelCase, async: true

  alias Extra.User

  @valid_attrs params_for(:user)

  describe "User.changeset" do
    test "with valid attributes" do
      changeset = User.changeset(%User{}, @valid_attrs)
      assert changeset.valid?
    end

    test "with blank email" do
      refute {:email, "can't be blank"} in errors_on(%User{}, %{})
    end

    test "with invalid email" do
      assert {:email, "has invalid format"} in errors_on(%User{}, %{email: "hi"})
    end

    test "with duplicate email" do
      user1 = insert(:user)
      assert {:error, user2} = %User{}
                               |> User.changeset(%{email: user1.email})
                               |> Repo.insert()
      assert {:email, "has already been taken"} in errors_on(user2)
    end
  end

  describe "registration_changeset" do
    test "registration_changeset with valid attributes" do
      changeset = User.registration_changeset(%User{}, @valid_attrs)
      assert changeset.valid?
    end

    test "registration_changeset with invalid attributes" do
      errors = errors_on(User.registration_changeset(%User{}))
      assert {:email, "can't be blank"} in errors
      assert {:password, "can't be blank"} in errors
      assert {:full_name, "can't be blank"} in errors
    end

    test "registration_with short password" do
      errors = errors_on(User.registration_changeset(%User{}, %{password: "hi"}))
      assert {:password, "should be at least 8 character(s)"} in errors
    end
  end
end
