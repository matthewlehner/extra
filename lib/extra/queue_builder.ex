defmodule Extra.QueueBuilder do
  @moduledoc """
  Functions for managing scheduling and posting for channels.
  """

  alias Extra.Repo
  alias Extra.Timeslot
  alias Extra.QueuedPost
  alias Extra.PostPicker

  require Logger

  def enqueue_posts do
    Logger.info "Enqueuing posts."
  end

  def build_from_timeslots do
    Logger.info("Building queue")

    posts = Timeslot
            |> Repo.all
            |> Timeslot.build_from_timeslots
            |> Enum.flat_map(&QueuedPost.for_timeslot/1)

    Repo.insert_all(QueuedPost, posts, on_conflict: :nothing)

    PostPicker.fill_empty_queue_slots()
  end
end
