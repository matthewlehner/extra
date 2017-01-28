defmodule Extra.SocialChannelTest do
  use Extra.ModelCase, async: true

  alias Extra.SocialChannel

  @valid_attrs params_for(:social_channel)

  test "changeset with valid attributes" do
    params =
      @valid_attrs
      |> Map.put(:authorization, params_for(:authorization))

    changeset =
      %SocialChannel{}
      |> SocialChannel.changeset(params)

    errors = errors_on(changeset)
    refute {:name, "can't be blank"} in errors
    refute {:provider, "can't be blank"} in errors
  end

  test "changeset with invalid attributes" do
    errors = errors_on(%SocialChannel{})
    assert {:name, "can't be blank"} in errors
    assert {:provider, "can't be blank"} in errors
    assert {:authorization, "can't be blank"} in errors
  end
end
