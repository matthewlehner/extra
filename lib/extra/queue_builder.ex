defmodule Extra.QueueBuilder do
  @moduledoc """
  Functions for managing scheduling and posting for channels.
  """

  alias Extra.Repo
  alias Extra.Timeslot
  alias Extra.QueuedPost
  alias Extra.PostPicker
  alias Extra.SchedulerRegistry

  require Logger

  def enqueue_posts do
    Logger.info "Enqueuing posts."
    Timeslot
    |> Repo.stream
    |> Stream.each(&SchedulerRegistry.add_job(Extra.SchedulerRegistry, &1))
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
