defmodule Extra.SchedulerRegistryTest do
  use Extra.ModelCase, async: true

  alias Extra.SchedulerRegistry
  alias Extra.TimeslotScheduler

  setup context do
    {:ok, registry} = Extra.SchedulerRegistry.start_link(context.test)
    {:ok, registry: registry}
  end

  test "spawns scheduler", %{registry: registry} do
    timeslot = insert(:timeslot)

    assert SchedulerRegistry.lookup(registry, timeslot.id) == :error

    SchedulerRegistry.create(registry, timeslot)
    assert {:ok, scheduler} = SchedulerRegistry.lookup(registry, timeslot.id)
    assert timeslot == TimeslotScheduler.timeslot(scheduler)
  end

  test "removes schedulers on exit", %{registry: registry} do
    timeslot = insert(:timeslot)
    SchedulerRegistry.create(registry, timeslot)
    {:ok, scheduler} = SchedulerRegistry.lookup(registry, timeslot.id)

    Agent.stop(scheduler)

    assert SchedulerRegistry.lookup(registry, timeslot.id) == :error
  end
end
