defmodule Extra.Factory do
  use ExMachina.Ecto, repo: Extra.Repo

  def user_factory do
    %Extra.User{
      full_name: "Kim Jansen",
      email: sequence(:email, &"kim-#{&1}@testusers.com"),
      password: "some long password string"
    }
  end

  def authorization_factory do
    %Extra.Authorization{
      expires_at: 42,
      provider: "twitter",
      refresh_token: "some content",
      token: "some content",
      uid: "some content"
    }
  end

  def post_collection_factory do
    %Extra.PostCollection{
      name: "some content"
    }
  end

  def post_content_factory do
    %Extra.PostContent{
      body: "some content",
      collection: build(:post_collection)
    }
  end

  def social_channel_factory do
    %Extra.SocialChannel{
      name: sequence(:name, &"Social Media Account ##{&1}"),
      provider: "Twitter"
    }
  end

  def with_channels(user) do
    insert_pair(:social_channel, user: user)
    user
  end
end
