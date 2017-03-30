defmodule Extra.Schema.Resolvers.Timeslot do
  @moduledoc """
  Resolver for the Timeslot object
  """
  alias Extra.Repo
  alias Extra.Timeslot
  alias Extra.Schedule

  def create(%{schedule_id: schedule_id, collection_id: collection_id, timeslot: timeslot_params}, _info) do
    params = Map.put_new timeslot_params, :collection_id, collection_id

    Schedule
    |> Repo.get(schedule_id)
    |> Ecto.build_assoc(:timeslots)
    |> Timeslot.changeset(params)
    |> Repo.insert
  end
end
