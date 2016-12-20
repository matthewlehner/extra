defmodule Extra.PostContentTest do
  use Extra.ModelCase

  alias Extra.PostContent

  @valid_attrs %{body: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = PostContent.changeset(%PostContent{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = PostContent.changeset(%PostContent{}, @invalid_attrs)
    refute changeset.valid?
  end
end
