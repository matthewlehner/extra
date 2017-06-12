defmodule Extra.TimeslotJob do
  @moduledoc """
  Sets up post scheduling for individual timeslots
  """

  require Logger

  @doc """
  Starts a new timeslot schedule
  """
  def start_link(timeslot) do
    Agent.start_link(fn -> initial_state(timeslot) end)
  end


  @doc """
  Gets timeslot
  """
  def timeslot(job) do
    Agent.get(job, &Map.get(&1, :timeslot))
  end

  defp initial_state(timeslot) do
    %{
      timeslot: timeslot,
      schedule: Extra.Timeslot.to_cron_expression(timeslot)
    }
  end

  def next_occurrence(job) do
    job
    |> Agent.get(&Map.get(&1, :schedule))
    |> Crontab.Scheduler.get_next_run_date()
  end

  def next_occurrence!(job) do
    {:ok, occurrence} = next_occurrence(job)
    occurrence
  end

  def schedule_post(job) do
    job
    |> next_occurrence!()
    |> Timex.diff(DateTime.utc_now(), :milliseconds)
    |> publish_after(job)
  end

  def publish_after(duration, job, pid \\ Extra.SchedulerRegistry) do
    Logger.info fn ->
      timeslot = Extra.TimeslotJob.timeslot(job)
      "publishing timeslot #{timeslot.id} in #{duration} milliseconds"
    end

    Process.send_after(pid, {:publish_post, job}, duration)
  end
end
