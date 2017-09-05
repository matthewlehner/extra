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
    assert {:uid, "can't be blank"} in errors
  end

  describe ".changeset/2" do
    setup do
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

      {:ok, user: user, params: params}
    end

    test "with a new channel", %{params: params, user: user} do
      assert {:ok, channel} =
        user
        |> Ecto.build_assoc(:social_channels)
        |> SocialChannel.changeset(params)
        |> Repo.insert()

      # It inserts an authorization
      assert %Extra.Authorization{} = channel.authorization
      assert channel.authorization.social_channel_id == channel.id

      # It inserts a schedule
      assert %Extra.Schedule{} = channel.schedule
      assert channel.schedule.social_channel_id == channel.id
      assert channel.user_id == user.id
    end

    test "with an existing channel", %{params: params, user: user} do
      {:ok, channel} =
        user
        |> Ecto.build_assoc(:social_channels)
        |> SocialChannel.changeset(params)
        |> Repo.insert()

      next_params = %Ueberauth.Auth{
        provider: :twitter,
        uid: "rando uid thingy",
        info: %Ueberauth.Auth.Info{
          nickname: "New Name",
          image: "A new url!"
        },
        credentials: %Ueberauth.Auth.Credentials{
          token: "I am a new token. Very secure.",
          secret: "This is a new secret."
        }
      }

      assert {:ok, next_channel} =
        channel
        |> SocialChannel.changeset(next_params)
        |> Repo.update()

      assert next_channel.name == next_params.info.nickname
      assert next_channel.image == next_params.info.image
      assert next_channel.authorization.token == next_params.credentials.token
      assert next_channel.authorization.secret == next_params.credentials.secret
    end
  end
end
