defmodule Extra.TimeslotJob do
  require Logger

  @moduledoc """
  Sets up post scheduling for individual timeslots
  """

  @doc """
  Starts a new timeslot schedule
  """
  def start_link(timeslot) do
    {:ok, job} = Agent.start_link(fn -> initial_state(timeslot) end)
    Agent.cast(job, &schedule_post/1)
    {:ok, job}
  end

  defp initial_state(timeslot) do
    %{
      timeslot: timeslot,
      schedule: Extra.Timeslot.to_cron_expression(timeslot)
    }
  end

  def next_occurrence(state) do
    state
    |> Map.get(:schedule)
    |> Crontab.Scheduler.get_next_run_date()
  end

  def next_occurrence!(state) do
    {:ok, occurrence} = next_occurrence(state)
    occurrence
  end

  def schedule_post(state) do
    timer =
      state
      |> next_occurrence!()
      |> Timex.diff(DateTime.utc_now(), :milliseconds)
      |> set_timer()

    Logger.info(fn ->
      "Scheduling timeslot #{state.timeslot.id} in" <>
      " #{Process.read_timer(timer)}ms"
    end)
    Map.put(state, :timer, timer)
  end

  def set_timer(duration) do
    Process.send_after(self(), {:"$gen_cast", {:cast, &publish/1}}, duration)
  end

  def publish(state) do
    Agent.cast(self(), &schedule_post/1)
    Extra.PublishingManager.publish_next_queued_post_for_timeslot(state.timeslot)
    state
  end

  def cancel(job) do
    Agent.get(job, &(Process.cancel_timer(&1.timer)))
    Agent.stop(job)
  end
end
