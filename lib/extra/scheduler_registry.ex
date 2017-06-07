defmodule Extra.SchedulerRegistry do
  @moduledoc """
  GenServer for publishing posts based timeslots.
  """

  use GenServer
  require Logger
  alias Extra.TimeslotJob

  ## Client API
  def start_link(name) do
    GenServer.start_link(__MODULE__, :ok, name: name)
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

  ## Server Callbacks

  def init(:ok) do
    # Probably going to want to use ETS here?
    schedulers = %{}
    refs = %{}
    {:ok, {schedulers, refs}}
  end

  def handle_call({:find_job, timeslot_id}, _from, {schedulers, _} = state) do
    {:reply, Map.fetch(schedulers, timeslot_id), state}
  end

  def handle_cast({:add_job, timeslot}, {schedulers, refs}) do
    if Map.has_key?(schedulers, timeslot.id) do
      {:noreply, {schedulers, refs}}
    else
      {:ok, pid} = TimeslotJob.start_link(timeslot)
      TimeslotJob.schedule_post(pid, self())
      ref = Process.monitor(pid)
      refs = Map.put(refs, ref, timeslot.id)
      schedulers = Map.put(schedulers, timeslot.id, pid)
      {:noreply, {schedulers, refs}}
    end
  end

  def handle_cast({:remove_job, timeslot_id}, {schedulers, refs}) do
    case Map.pop(schedulers, timeslot_id) do
      {nil, _} ->
        {:noreply, {schedulers, refs}}
      {job, schedulers} ->
        Agent.stop(job)
        {:noreply, {schedulers, refs}}
    end
  end

  def handle_info({:publish_post, job}, state) do
    timeslot = TimeslotJob.timeslot(job)
    Logger.info(fn -> "Publishing a post for timeslot #{timeslot.id}" end)

    {:noreply, state}
  end

  def handle_info({:DOWN, ref, :process, _pid, _reason}, {schedulers, refs}) do
    {timeslot_id, refs} = Map.pop(refs, ref)
    schedulers = Map.delete(schedulers, timeslot_id)
    {:noreply, {schedulers, refs}}
  end

  def handle_info(_msg, state) do
    {:noreply, state}
  end
end
