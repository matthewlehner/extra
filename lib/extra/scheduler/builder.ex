defmodule Extra.Scheduler.Builder do
  @moduledoc """
  Builds empty queue slots and fills them with posts periodically.
  """

  use GenServer
  alias Extra.QueueBuilder

  @hourly Crontab.CronExpression.Parser.parse!("0 * * * *")

  def start_link do
    GenServer.start_link(__MODULE__, %{})
  end

  def init(state) do
    schedule_work()
    Task.start(&QueueBuilder.enqueue_posts/0)
    {:ok, state}
  end

  def handle_info(:work, state) do
    schedule_work()
    QueueBuilder.build_from_timeslots()
    {:noreply, state}
  end

  defp schedule_work do
    ms_from_now =
      @hourly
      |> Crontab.Scheduler.get_next_run_date()
      |> Timex.diff(DateTime.utc_now(), :milliseconds)

    Process.send_after(self(), :work, ms_from_now)
  end
end
