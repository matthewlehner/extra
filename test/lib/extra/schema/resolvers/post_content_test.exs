defmodule Extra.Schema.Resolvers.PostContentTest do
  use Extra.ModelCase, async: true

  alias Extra.PostContent
  alias Extra.Schema.Resolvers.PostContent, as: PostContentResolver

  describe "get/2" do
    test "gets post content by id" do
      user = insert :user
      collection = insert :post_collection, user: user
      post = insert :post_content, collection: collection

      params = %{id: post.id}
      context = %{context: %{current_user: user}}

      assert {:ok, %PostContent{id: id}} = PostContentResolver.get(params, context)
      assert id == post.id
    end

    test "does not return posts that user doesn't own" do
      user = insert :user
      post = insert :post_content

      params = %{id: post.id}
      context = %{context: %{current_user: user}}

      error = "A post with id #{post.id} could not be found"

      assert {:error, error} == PostContentResolver.get(params, context)
    end
  end

  describe "create/2" do
    test "adds new post content" do
      user = insert :user
      channels = insert_pair :social_channel, user: user
      collection = insert :post_collection, user: user

      channel_ids = Enum.map channels, &(&1.id)
      body = "something else!"

      params = %{
        input: %{
          body: body,
          collection_id: collection.id,
          channel_ids: channel_ids
        }
      }

      info = %{context: %{current_user: %{id: user.id}}}

      assert {:ok, %{content: content}} = PostContentResolver.create(params, info)
      assert content.body == body
      assert content.post_collection_id == collection.id
      assert is_number(content.id)
    end

    test "requires current user" do
      assert {:error, "Not Authorized"} = PostContentResolver.create(%{}, %{})
    end
  end

  describe "update/2" do
    test "updates the post content" do
      user = insert :user
      collection = insert :post_collection, user: user
      [channel1 | [channel2 | [channel3]]] = insert_list 3, :social_channel
      post = :post_content
             |> insert(collection: collection)
             |> with_template_for(channel1)
             |> with_template_for(channel2)

      params = %{
        input: %{
          id: post.id,
          body: "I'm a new body",
          channel_ids: [to_string(channel1.id), to_string(channel3.id)]
        }
      }
      context = %{context: %{current_user: user}}

      response = PostContentResolver.update(params, context)
      assert {:ok, %{content: post_content}} = response
      post_content = Repo.preload(post_content, :channels)
      assert post_content.id == post.id
      assert post_content.body == "I'm a new body"
      assert post_content.channels == [channel1, channel3]
    end
  end

  describe "archive/2" do
    test "archives the post" do
      %{
        user: user,
        collection: collection
      } = insert_channel_resources()
      content = insert :post_content, collection: collection

      params = %{id: content.id}
      context = %{context: %{current_user: user}}

      assert {:ok, next_content} = PostContentResolver.archive(params, context)
      assert %DateTime{} = next_content.archived_at
    end

    test "it clears the post from queued posts" do
      %{
        user: user,
        channel: channel,
        collection: collection
      } = insert_channel_resources()
      content = insert :post_content, collection: collection
      template = insert :post_template, post_content: content,
                                        social_channel: channel
      queued_post = insert :queued_post, post_template: template

      params = %{id: content.id}
      context = %{context: %{current_user: user}}

      assert {:ok, _} = PostContentResolver.archive(params, context)
      assert %Extra.QueuedPost{post_template_id: nil} = Repo.get(Extra.QueuedPost, queued_post.id)
    end

    test "can't archive post that doesn't belong to user" do
      user = insert :user
      content = insert :post_content

      params = %{id: content.id}
      context = %{context: %{current_user: user}}

      error_msg = "A post with id #{content.id} could not be found"

      assert {:error, error_msg} == PostContentResolver.archive(params, context)
    end
  end
end
