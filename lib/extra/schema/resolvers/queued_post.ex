defmodule Extra.Schema.Resolvers.QueuedPostResolver do
  @moduledoc """
  Resolver for the QueuedPost schema
  """

  import Ecto.Query
  alias Extra.Repo
  alias Extra.QueuedPost

  def for_channel(_parent, %{channel_id: channel_id}, %{context: %{current_user: user}}) do
    queued_posts =
      QueuedPost
      |> QueuedPost.for_user(user)
      |> where([p], p.channel_id == ^channel_id)
      |> Repo.all()

    case queued_posts do
      nil -> {:error, "There is no queue for channel id #{channel_id}"}
      _   -> {:ok, queued_posts}
    end
  end
end
