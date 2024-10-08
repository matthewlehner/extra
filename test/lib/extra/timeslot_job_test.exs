defmodule Extra.TimeslotJobTest do
  use Extra.ModelCase, async: true

  alias Extra.TimeslotJob
  alias Extra.Timeslot

  setup do
    timeslot = insert :timeslot
    {:ok, job} = TimeslotJob.start_link(timeslot)
    {:ok, job: job, timeslot: timeslot}
  end

  describe "state" do
    test "stores timeslot_id", %{job: job, timeslot: timeslot} do
      assert Agent.get(job, &(&1)).timeslot_id == timeslot.id
    end

    test "sets timezone", %{job: job, timeslot: timeslot} do
      assert Agent.get(job, &(&1)).timezone == timeslot.schedule.timezone
    end

    test"sets default timezone when not passed in", %{timeslot: timeslot} do
      timeslot = Repo.get(Timeslot, timeslot.id)
      {:ok, job} = TimeslotJob.start_link(timeslot)

      assert Agent.get(job, &(&1)).timezone == "America/Vancouver"
    end

    test "schedule", %{job: job, timeslot: timeslot} do
      schedule = Agent.get(job, &(&1)).schedule
      expected_schedule = Timeslot.to_cron_expression(timeslot)

      assert schedule == expected_schedule
    end
  end

  test "gets next ocurrence", %{job: job, timeslot: timeslot} do
    state = Agent.get(job, &(&1))

    next_date =
      timeslot
      |> Timeslot.to_cron_expression()
      |> Crontab.Scheduler.get_next_run_date!()
      |> Timex.to_datetime(timeslot.schedule.timezone)

    expected_date = TimeslotJob.next_occurrence!(state)

    assert next_date == expected_date
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
