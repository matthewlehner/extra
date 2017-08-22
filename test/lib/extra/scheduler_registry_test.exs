defmodule Extra.SchedulerRegistryTest do
  use Extra.ModelCase, async: true

  alias Extra.SchedulerRegistry

  setup context do
    {:ok, registry} = SchedulerRegistry.start_link(context.test)
    {:ok, registry: registry}
  end

  test ".add_job", %{registry: registry} do
    timeslot = insert(:timeslot)

    assert SchedulerRegistry.find_job(registry, timeslot) == :error

    SchedulerRegistry.add_job(registry, timeslot)
    assert {:ok, scheduler} = SchedulerRegistry.find_job(registry, timeslot)
    assert timeslot == Agent.get(scheduler, &(&1)).timeslot
  end

  test ".remove_job", %{registry: registry} do
    timeslot = insert(:timeslot)
    SchedulerRegistry.add_job(registry, timeslot)
    SchedulerRegistry.remove_job(registry, timeslot)
    assert SchedulerRegistry.find_job(registry, timeslot) == :error
  end

  test "removes schedulers on exit", %{registry: registry} do
    timeslot = insert(:timeslot)
    SchedulerRegistry.add_job(registry, timeslot)
    {:ok, scheduler} = SchedulerRegistry.find_job(registry, timeslot.id)

    Agent.stop(scheduler)

    assert SchedulerRegistry.find_job(registry, timeslot) == :error
  end
end
