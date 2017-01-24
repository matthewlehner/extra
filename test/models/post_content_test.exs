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

    test "with templates params" do
      social_channel = insert(:social_channel)
      collection = insert(:post_collection)

      params = %{
        body: "some content",
        post_collection_id: collection.id,
        templates: %{
          "0" => %{active: true, social_channel_id: social_channel.id}
        }
      }

      assert {:ok, post} =
        %PostContent{}
        |> PostContent.changeset(params)
        |> Repo.insert()

      [template | _] = post.templates
      assert template.post_content_id == post.id
    end
  end
end
