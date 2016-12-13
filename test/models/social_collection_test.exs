defmodule Extra.SocialCollectionTest do
  use Extra.ModelCase

  alias Extra.SocialCollection

  @valid_attrs %{name: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = SocialCollection.changeset(%SocialCollection{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = SocialCollection.changeset(%SocialCollection{}, @invalid_attrs)
    refute changeset.valid?
  end
end
