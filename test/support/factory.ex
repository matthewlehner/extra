defmodule Extra.Factory do
  use ExMachina.Ecto, repo: Extra.Repo

  def user_factory do
    %Extra.User{
      full_name: "Kim Jansen",
      email: sequence(:email, &"kim-#{&1}@testusers.com"),
      password: "some long password string"
    }
  end
end
