defmodule Extra.SocialPostTest do
  use Extra.ModelCase

  alias Extra.SocialPost

  @valid_attrs params_for(:social_post)

  describe "changeset" do
    test "with valid attributes" do
      changeset = SocialPost.changeset(%SocialPost{}, @valid_attrs)
      assert changeset.valid?
    end

    test "required attributes" do
      errors = errors_on(%SocialPost{})
      assert {:content, "can't be blank"} in errors
      assert {:platform_entity_id, "can't be blank"} in errors
      assert {:raw_response, "can't be blank"} in errors
      assert {:published_at, "can't be blank"} in errors
    end
  end
end
