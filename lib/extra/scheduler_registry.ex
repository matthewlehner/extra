defmodule Extra.SchedulerRegistry do
  @moduledoc """
  Registry for the Scheduler for publishing posts based on timeslots.
  """

  ## Client API
  def start_link(name) do
    GenServer.start_link(Extra.SchedulerRegistry.Server, :ok, name: name)
  end

  @doc """
  Looks up the timeslot pid for `name` stored in `server`.

  Returns `{:ok, pid}` if the timeslot exists, `:error` otherwise.
  """
  def find_job(server, %{id: timeslot_id}), do: find_job(server, timeslot_id)
  def find_job(server, timeslot_id) do
    GenServer.call(server, {:find_job, timeslot_id})
  end

  @doc """
  Ensures there is a TimeslotJob associated to the given `name` in `server`.
  """
  def add_job(server, timeslot) do
    GenServer.cast(server, {:add_job, timeslot})
  end

  @doc """
  Removes a timeslot's job from the registry.
  """
  def remove_job(server, %{id: timeslot_id}) do
    GenServer.cast(server, {:remove_job, timeslot_id})
  end
end
