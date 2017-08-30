defmodule Extra.PublishingManager do
  @moduledoc """
  Functions to take content and publish it to the platform of choice.
  """

  import Ecto.Query
  import Ecto, only: [assoc: 2]
  alias Extra.Repo

  def publish_next_queued_post_for_timeslot(timeslot) do
    query = next_queued_post(timeslot)

    case Repo.one(query) do
      queued_post -> publish_queued_post(queued_post)
    end
  end

  def next_queued_post(timeslot) do
    timeslot
    |> assoc(:queued_posts)
    |> order_by(asc: :scheduled_for)
    |> limit(1)
    |> join(:left, [p], c in assoc(p, :channel))
    |> join(:left, [p, c], a in assoc(c, :authorization))
    |> join(:left, [p], t in assoc(p, :post_template))
    |> join(:left, [p], pc in assoc(p, :post_content))
    |> preload([p, c, a, t, pc],
               [channel: {c, authorization: a},
                post_template: t,
                post_content: pc])
  end

  def publish_queued_post(queued_post) do


    # After the post is confirmed to be published
    clean_up_queued_post(queued_post)
  end

  def build_post(queued_post) do
    params = %{
      content: queued_post.post_content.body
    }
  end

  def clean_up_queued_post(queued_post) do
    Repo.delete(queued_post)
  end
end
