defmodule Extra.PostTemplateTest do
  use Extra.ModelCase

  alias Extra.PostTemplate

  describe "PostTemplate.changeset" do
    test "creates post template with proper associations." do
      channel = insert(:social_channel)
      content = insert(:post_content)

      changeset =
        content
        |> build_assoc(:templates)
        |> PostTemplate.changeset(%{social_channel_id: channel.id})

      assert {:ok, _} = Repo.insert(changeset)
    end

    test "social channel associations can't be blank" do
      assert {:social_channel_id, "can't be blank"} in errors_on(%PostTemplate{})
    end
  end
end
