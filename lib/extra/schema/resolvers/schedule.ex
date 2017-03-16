defmodule Extra.Schema.Resolvers.Schedule do
  @moduledoc """
  Resolver for the Schedule object
  """
  alias Extra.Repo
  alias Extra.Schedule

  def find_by(_parent, %{channel_id: channel_id}, _info) do
    case Repo.get_by(Schedule, social_channel_id: channel_id) do
      nil      -> {:error, "There is no schedule for channel id #{channel_id}"}
      schedule -> {:ok, schedule}
    end
  end
end
