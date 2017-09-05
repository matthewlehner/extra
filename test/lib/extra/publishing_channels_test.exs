defmodule Extra.PublishingChannelsTest do
  use Extra.ModelCase, async: true
  alias Extra.PublishingChannels

  setup context do
    user = insert(:user)
    auth_params = %Ueberauth.Auth{
      provider: :twitter,
      uid: "a uid #{context.test}",
      info: %Ueberauth.Auth.Info{
        nickname: "I'm a name",
        image: "I'm an image url."
      },
      credentials: %Ueberauth.Auth.Credentials{
        token: "JRR Token #{context.test}",
        secret: "What have I got in my pocket?"
      }
    }
    {:ok, user: user, auth_params: auth_params}
  end

  test ".get_from_auth", %{user: user} do
    channel = insert(:social_channel, user: user)
    auth = %Ueberauth.Auth {
      provider: :twitter,
      uid: channel.uid
    }

    assert loaded_channel = PublishingChannels.get_from_auth(auth, user)
    assert loaded_channel.id == channel.id
  end

  describe ".load_or_build/2" do
    test "returns a channel if it exists", %{user: user} do
      channel = insert(:social_channel, user: user)
      auth = %Ueberauth.Auth {
        provider: :twitter,
        uid: channel.uid
      }

      assert loaded_channel = PublishingChannels.load_or_build(auth, user)
      assert loaded_channel.id == channel.id
    end
  end

  describe ".persist_ueberauth_response/2" do
    test "creates a new channel and authorization", %{auth_params: auth_params, user: user} do
      assert {:ok, channel} = PublishingChannels.persist_ueberauth_response(auth_params, user)
      assert channel.id
      assert channel.name == auth_params.info.nickname
      assert channel.image == auth_params.info.image
      assert channel.authorization.token == auth_params.credentials.token
      assert channel.authorization.secret == auth_params.credentials.secret
    end

    test "updates a channel and authorization", %{auth_params: auth_params, user: user} do
      channel = insert(:social_channel, uid: auth_params.uid, user: user)
      assert {:ok, next_channel} = PublishingChannels.persist_ueberauth_response(auth_params, user)

      assert next_channel.id == channel.id
      assert next_channel.name == auth_params.info.nickname
      assert next_channel.image == auth_params.info.image
      assert next_channel.authorization.token == auth_params.credentials.token
      assert next_channel.authorization.secret == auth_params.credentials.secret
    end
  end
end
