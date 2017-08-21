defmodule Extra.TimeslotJobTest do
  use Extra.ModelCase, async: true

  alias Extra.TimeslotJob
  alias Extra.Timeslot

  setup do
    timeslot = insert :timeslot
    {:ok, job} = TimeslotJob.start_link(timeslot)
    {:ok, job: job, timeslot: timeslot}
  end

  test "stores timeslot", %{job: job, timeslot: timeslot} do
    assert TimeslotJob.timeslot(job) == timeslot
  end

  test "gets next ocurrence", %{job: job, timeslot: timeslot} do
    next_date =
      timeslot
      |> Timeslot.to_cron_expression()
      |> Crontab.Scheduler.get_next_run_date()

    assert TimeslotJob.next_occurrence(Agent.get(job, &(&1))) == next_date
  end

  test "schedule_post", %{job: job} do
    timer =
      job
      |> Agent.get(&(&1))
      |> TimeslotJob.schedule_post()
      |> Map.fetch!(:timer)
    assert is_reference(timer)
  end

  test ".set_timer/1" do
    TimeslotJob.set_timer(10)

    assert_receive {:"$gen_cast", {:cast, callback}}
    assert is_function(callback)
  end
end
