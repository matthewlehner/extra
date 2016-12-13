defmodule Extra.PostCollectionTest do
  use Extra.ModelCase

  alias Extra.PostCollection

  @valid_attrs %{name: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = PostCollection.changeset(%PostCollection{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = PostCollection.changeset(%PostCollection{}, @invalid_attrs)
    refute changeset.valid?
  end
end
