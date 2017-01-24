defmodule Extra.PostCollectionTest do
  use Extra.ModelCase

  alias Extra.PostCollection

  @valid_attrs params_for :post_collection

  describe "PostCollection.changeset" do
    test "changeset with valid attributes" do
      changeset = PostCollection.changeset(%PostCollection{}, @valid_attrs)
      assert changeset.valid?
    end

    test "name can't be blank" do
      assert {:name, "can't be blank"} in errors_on(%PostCollection{}, %{})
    end
  end
end
