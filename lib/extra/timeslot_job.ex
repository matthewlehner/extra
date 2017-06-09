defmodule Extra.TimeslotJob do
  @moduledoc """
  Sets up post scheduling for individual timeslots
  """

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

  require Logger
  def publish_after(duration, job) do
    Logger.info fn -> "publishing in #{duration} milliseconds" end

    Process.send_after(Extra.SchedulerRegistry, {:publish_post, job}, duration)
  end
end
