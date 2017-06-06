defmodule Extra.TimeslotSchedulerTest do
  use ExUnit.Case, async: true

  alias Extra.TimeslotScheduler

  setup do
    {:ok, scheduler} = TimeslotScheduler.start_link(:timeslot)
    {:ok, scheduler: scheduler}
  end

  test "stores timeslot", %{scheduler: scheduler} do
    assert Extra.TimeslotScheduler.timeslot(scheduler) == :timeslot
  end
end
