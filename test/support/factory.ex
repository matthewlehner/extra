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
end
