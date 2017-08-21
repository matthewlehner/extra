defmodule Extra.SchedulerRegistry.Server do
  use GenServer
  alias Extra.TimeslotJob

  @moduledoc """
  GenServer implementation for SchedulerRegistry
  """

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
        TimeslotJob.cancel(job)
        {:noreply, {schedulers, refs}}
    end
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
