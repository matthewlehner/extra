defmodule Extra.PostContentTest do
  use Extra.ModelCase, async: true

  alias Extra.PostContent

  @valid_attrs params_for :post_content

  describe "PostContent.changeset" do
    test "changeset with valid attributes" do
      collection = insert(:post_collection, user: build(:user))
      attrs = Map.put_new(@valid_attrs, :post_collection_id, collection.id)

      changeset = PostContent.changeset(%PostContent{}, attrs)
      assert changeset.valid?
    end

    test "with blank body" do
      assert {:body, "can't be blank"} in errors_on(%PostContent{})
    end

    test "with blank user" do
      assert {:post_collection_id, "can't be blank"} in errors_on(%PostContent{})
    end

    test "with templates params" do
      channel = insert(:social_channel)
      collection = insert(:post_collection)

      params = %{
        body: "some content",
        post_collection_id: collection.id,
        templates: %{
          "0" => %{active: true, social_channel_id: channel.id}
        }
      }

      assert {:ok, post} =
        %PostContent{}
        |> PostContent.changeset(params)
        |> Repo.insert()

      assert [first_template | _] = post.templates
      assert first_template.post_content_id == post.id
    end
  end

  describe "build_unassociated_templates" do
    test "generate a list of unassociated channels" do
      channels = insert_pair(:social_channel)
      [channel | unassociated_channels] = channels

      post = :post_content
             |> insert()
             |> with_template_for(channel)

      templates = PostContent.build_potential_templates(post, channels)

      assert Enum.map(unassociated_channels, &(&1.id)) ==
             Enum.map(templates, &(&1.social_channel_id))
    end

    test "works with new post templates" do
      channels = insert_pair(:social_channel)

      post = PostContent.changeset(%PostContent{})
      templates = PostContent.build_potential_templates(post.data, channels)

      assert Enum.map(channels, &(&1.id)) ==
             Enum.map(templates, &(&1.social_channel_id))
    end
  end
end
