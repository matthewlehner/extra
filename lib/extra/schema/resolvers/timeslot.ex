defmodule Extra.Schema.Resolvers.Timeslot do
  @moduledoc """
  Resolver for the Timeslot object
  """
  alias Extra.Repo
  alias Extra.Timeslot

  def create(%{timeslot: timeslot_params}, %{context: %{current_user: user}}) do
    response = %Timeslot{}
               |> Timeslot.changeset_for_user(timeslot_params, user)
               |> Repo.insert()

    case response do
      {:ok, timeslot} -> Timeslot.build_post_queue(timeslot)
    end

    response
  end

  def delete(timeslot_id, %{context: %{current_user: user}}) do
    timeslot = Timeslot
               |> Timeslot.for_user(user)
               |> Repo.get(timeslot_id)

    case timeslot do
      nil      -> {:error, "Timeslot #{timeslot_id} not found"}
      timeslot -> delete_timeslot(timeslot)
    end
  end

  defp delete_timeslot(timeslot) do
    timeslot
    |> Repo.delete!()
    |> deregister_job
    {:ok, timeslot}
  end

  defp deregister_job(timeslot) do
    Extra.SchedulerRegistry.remove_job(Extra.SchedulerRegistry, timeslot)
  end
end
