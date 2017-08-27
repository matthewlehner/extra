defmodule Extra.Extra.SocialPostTest do
  use Extra.ModelCase

  alias Extra.Extra.SocialPost

  @valid_attrs %{channel_post_id: "some content", content: "some content", published_at: %{day: 17, hour: 14, min: 0, month: 4, sec: 0, year: 2010}, response: %{}}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = SocialPost.changeset(%SocialPost{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = SocialPost.changeset(%SocialPost{}, @invalid_attrs)
    refute changeset.valid?
  end
end
