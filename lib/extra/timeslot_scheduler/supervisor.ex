defmodule Extra.TimeslotScheduler.Supervisor do
  use Supervisor

  @name Extra.TimeslotScheduler.Supervisor

  def start_link do
    Supervisor.start_link(__MODULE__, :ok, name: @name)
  end

  def start_timeslot_scheduler do
    Supervisor.start_child(@name, [])
  end

  def init(:ok) do
    children = [
      worker(Extra.TimeslotScheduler, [], restart: :temporary)
    ]

    supervise(children, strategy: :simple_one_for_one)
  end
end
