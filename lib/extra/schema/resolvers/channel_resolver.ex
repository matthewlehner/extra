defmodule Extra.Schema.ChannelResolver do
  @moduledoc """
  Channel Resolver for GraphQL Channel object type.
  Grabs channels from the db.
  """
  alias Extra.Repo
  alias Extra.SocialChannel

  def all(_args, _info) do
    {:ok, Repo.all(SocialChannel)}
  end

  def find(%{id: id}, _info) do
    case Repo.get(SocialChannel, id) do
      nil     -> {:error, "Channel id #{id} not found"}
      channel -> {:ok, channel}
    end
  end
end
