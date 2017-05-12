defmodule Extra.Schema.Resolvers.Schedule do
  @moduledoc """
  Resolver for the Schedule object
  """
  import Ecto.Query
  alias Extra.Repo
  alias Extra.Schedule
  alias Extra.SocialChannel

  def find_by(_parent, %{channel_id: channel_id}, %{context: %{current_user: user}}) do
    schedule =
      Schedule
      |> Schedule.for_user(user)
      |> Repo.get_by(social_channel_id: channel_id)

    case schedule do
      nil      -> {:error, "There is no schedule for channel id #{channel_id}"}
      %Schedule{} -> {:ok, schedule}
    end
  end

  def update(%{channel_id: channel_id, schedule: schedule_params}, %{context: %{current_user: user}}) do
    Schedule
    |> Schedule.for_user(user)
    |> Repo.get_by!(social_channel_id: channel_id)
    |> Schedule.changeset(schedule_params)
    |> Repo.update
  end
end
