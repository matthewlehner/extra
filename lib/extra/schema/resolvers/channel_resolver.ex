defmodule Extra.Schema.ChannelResolver do
  @moduledoc """
  Channel Resolver for GraphQL Channel object type.
  Grabs channels from the db.
  """
  import Ecto.Query, only: [where: 2]
  alias Extra.Repo
  alias Extra.SocialChannel

  def all(_args, %{context: %{current_user: %{id: id}}}) do
    channels =
      SocialChannel
      |> where(user_id: ^id)
      |> Repo.all
    {:ok, channels}
  end

  def all(_args, _info), do: {:error, "Not Authorized"}

  def find(%{id: id}, %{context: %{current_user: %{id: user_id}}}) do
    channel =
      SocialChannel
      |> where(user_id: ^user_id)
      |> Repo.get(id)

    case channel do
      nil     -> {:error, "Channel id #{id} not found"}
      channel -> {:ok, channel}
    end
  end

  def find(_, _), do: {:error, "Not Authorized"}
end
