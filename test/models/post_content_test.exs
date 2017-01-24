defmodule Extra.PostContentTest do
  use Extra.ModelCase

  alias Extra.PostContent

  @valid_attrs params_for :post_content

  describe "PostContent.changeset" do
    test "changeset with valid attributes" do
      collection = insert(:post_collection, user: build(:user))
      attrs = %{@valid_attrs | post_collection_id: collection.id}

      changeset = PostContent.changeset(%PostContent{}, attrs)
      assert changeset.valid?
    end

    test "with blank body" do
      assert {:body, "can't be blank"} in errors_on(%PostContent{}, %{})
    end

    test "with blank user" do
      assert {:post_collection_id, "can't be blank"} in errors_on(%PostContent{}, %{})
    end
  end
end
