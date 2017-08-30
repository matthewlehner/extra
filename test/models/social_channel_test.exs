defmodule Extra.SocialChannelTest do
  use Extra.ModelCase, async: true

  alias Extra.SocialChannel
  alias Extra.Repo

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

  describe "changeset_from_auth" do
    test "creates new records" do
      user = insert(:user)
      params = %Ueberauth.Auth{
        provider: :twitter,
        uid: "rando uid thingy",
        info: %Ueberauth.Auth.Info{
          nickname: "ExtraAI",
          image: "A url! For real"
        },
        credentials: %Ueberauth.Auth.Credentials{
          token: "I am a great token. The best token. Very secure.",
          secret: "This is a secret."
        }
      }
      changeset = SocialChannel.changeset_from_auth(params, user)

      # It inserts a channel
      assert {:ok, channel} = Repo.insert(changeset)

      # It inserts an authorization
      assert %Extra.Authorization{} = channel.authorization
      assert channel.authorization.social_channel_id == channel.id

      # It inserts a schedule
      assert %Extra.Schedule{} = channel.schedule
      assert channel.schedule.social_channel_id == channel.id
    end
  end
end
