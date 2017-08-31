defmodule Extra.QueueBuilder do
  @moduledoc """
  Functions for managing scheduling and posting for channels.
  """

  import Ecto.Query
  alias Extra.Repo
  alias Extra.Timeslot
  alias Extra.QueuedPost
  alias Extra.PostPicker
  alias Extra.SchedulerRegistry

  require Logger

  def enqueue_posts do
    Repo.transaction fn ->
      Logger.info "Enqueuing posts."

      Timeslot
      |> timeslot_query()
      |> Repo.stream()
      |> Stream.each(fn(timeslot) ->
        SchedulerRegistry.add_job(Extra.SchedulerRegistry, timeslot)
      end)
      |> Stream.run()
    end
  end

  defp timeslot_query(query) do
    from ts in query,
      join: s in assoc(ts, :schedule),
      preload: [schedule: s]
  end

  def build_from_timeslots do
    Logger.info("Building queue")

    posts = Timeslot
            |> Repo.all
            |> Enum.flat_map(&QueuedPost.for_timeslot/1)

    Repo.insert_all(QueuedPost, posts, on_conflict: :nothing)

    PostPicker.fill_empty_queue_slots()
  end
end
