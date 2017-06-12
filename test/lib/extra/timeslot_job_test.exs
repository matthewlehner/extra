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
    next_date = timeslot
                |> Timeslot.to_cron_expression()
                |> Crontab.Scheduler.get_next_run_date()

    assert TimeslotJob.next_occurrence(job) == next_date
  end

  test "schedule_post", %{job: job} do
    timer = TimeslotJob.schedule_post(job)
    assert is_reference(timer)
  end

  test ".publish_after", %{job: job}  do
    TimeslotJob.publish_after(10, job, self())

    assert_receive {:publish_post, ^job}
  end
end
