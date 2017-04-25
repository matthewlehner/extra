defmodule Extra.Schema.Resolvers.PostContentTest do
  use Extra.ModelCase, async: true

  require Extra.Schema.Resolvers.PostContent, as: PostContentResolver

  describe "create/2" do
    test "adds new post content" do
      user = insert :user
      channels = insert_pair :social_channel, user: user
      collection = insert :post_collection, user: user

      channel_ids = Enum.map channels, &(&1.id)
      body = "something else!"

      params = %{
        body: body,
        collection_id: collection.id,
        channel_ids: channel_ids
      }

      info = %{context: %{current_user: %{id: user.id}}}

      assert {:ok, post} = PostContentResolver.create(params, info)
      assert post.body == body
      assert post.post_collection_id == collection.id
      assert is_number(post.id)
    end

    test "requires current user" do
      assert {:error, "Not Authorized"} = PostContentResolver.create(%{}, %{})
    end
  end
end

