defmodule Extra.PublishingChannels do
  @moduledoc """
  Context for manging attributes to do with publishing channels
  """

  import Ecto.Query
  alias Extra.Repo
  alias Extra.SocialChannel

  def get_from_auth(%Ueberauth.Auth{uid: uid}, user) do
    SocialChannel
    |> preload(:authorization)
    |> Repo.get_by(uid: uid, user_id: user.id)
  end

  def load_or_build(auth, user) do
    case get_from_auth(auth, user) do
      nil -> Ecto.build_assoc(user, :social_channels)
      channel -> channel
    end
  end

  def persist_ueberauth_response(auth, user) do
    auth
    |> load_or_build(user)
    |> SocialChannel.changeset(auth)
    |> Repo.insert_or_update()
  end
end
