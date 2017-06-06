defmodule Extra.TimeslotScheduler do
  @doc """
  Starts a new timeslot schedule
  """
  def start_link(timeslot) do
    Agent.start_link(fn -> %{timeslot: timeslot} end)
  end


  @doc """
  Gets timeslot
  """
  def timeslot(scheduler) do
    Agent.get(scheduler, &Map.get(&1, :timeslot))
  end
end
