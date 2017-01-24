defmodule Extra.SocialChannelTest do
  use Extra.ModelCase, async: true

  alias Extra.SocialChannel

  @valid_attrs %{name: "some content", provider: "test", authorization: %{}}

  test "changeset with valid attributes" do
    errors = errors_on(%SocialChannel{}, @valid_attrs)
    refute {:name, "can't be blank"} in errors
    refute {:provider, "can't be blank"} in errors
    # TODO - Make this better. Probably need ex_machina at this point.
    assert Keyword.has_key?(errors, :authorization)
  end

  test "changeset with invalid attributes" do
    errors = errors_on(%SocialChannel{})
    assert {:name, "can't be blank"} in errors
    assert {:provider, "can't be blank"} in errors
    assert {:authorization, "can't be blank"} in errors
  end
end
