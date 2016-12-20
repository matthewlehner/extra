defmodule Extra.PostTemplateTest do
  use Extra.ModelCase

  alias Extra.PostTemplate

  @valid_attrs %{}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = PostTemplate.changeset(%PostTemplate{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = PostTemplate.changeset(%PostTemplate{}, @invalid_attrs)
    refute changeset.valid?
  end
end
