defmodule Extra.PublishingManager.Collector do
  @moduledoc """
  Holds timeslots that are ready for publishing in a FIFO queue to be consumed by a later stage with GenStage.
  """

  use GenStage
  alias Extra.Queue

  def start_link() do
    GenStage.start_link(__MODULE__, :ok, name: __MODULE__)
  end

  def init(:ok) do
    {:producer, Queue.new()}
  end

  def handle_demand(demand, queue) when demand > 0 do
    {items, updated_queue} = Queue.take(queue, demand)
    {:noreply, items, updated_queue}
  end

  def add(timeslot_id) do
    GenStage.cast(__MODULE__, {:push, timeslot_id})
  end

  def handle_cast({:push, timeslot_id}, queue) do
    updated_queue = Queue.enqueue(queue, timeslot_id)
    {:noreply, [], updated_queue}
  end
end
