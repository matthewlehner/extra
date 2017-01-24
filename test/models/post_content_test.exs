defmodule Extra.PostContentTest do
  use Extra.ModelCase

  alias Extra.PostContent

  @valid_attrs params_for :post_content

  describe "PostContent.changeset" do
    test "changeset with valid attributes" do
      changeset = PostContent.changeset(%PostContent{}, @valid_attrs)
      assert changeset.valid?
    end

    test "with blank body" do
      assert {:body, "can't be blank"} in errors_on(%PostContent{}, %{})
    end
  end
end
