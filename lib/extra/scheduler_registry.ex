defmodule Extra.SchedulerRegistry do
  @moduledoc """
  GenServer for publishing posts based timeslots.
  """

  use GenServer

  ## Client API
  def start_link(name) do
    GenServer.start_link(__MODULE__, :ok, name: name)
  end

  @doc """
  Looks up the timeslot pid for `name` stored in `server`.

  Returns `{:ok, pid}` if the timeslot exists, `:error` otherwise.
  """
  def lookup(server, timeslot_id) do
    GenServer.call(server, {:lookup, timeslot_id})
  end

  @doc """
  Ensures there is a TimeslotJob associated to the given `name` in `server`.
  """
  def create(server, timeslot) do
    GenServer.cast(server, {:create, timeslot})
  end

  ## Server Callbacks

  def init(:ok) do
    # Probably going to want to use ETS here?
    schedulers = %{}
    refs = %{}
    {:ok, {schedulers, refs}}
  end

  def handle_call({:lookup, timeslot_id}, _from, {schedulers, _} = state) do
    {:reply, Map.fetch(schedulers, timeslot_id), state}
  end

  def handle_cast({:create, timeslot}, {schedulers, refs}) do
    if Map.has_key?(schedulers, timeslot.id) do
      {:noreply, {schedulers, refs}}
    else
      {:ok, pid} = Extra.TimeslotScheduler.start_link(timeslot)
      ref = Process.monitor(pid)
      refs = Map.put(refs, ref, timeslot.id)
      schedulers = Map.put(schedulers, timeslot.id, pid)
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
