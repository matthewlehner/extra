defmodule Extra.PublishingManager do
  @moduledoc """
  Functions to take content and publish it to the platform of choice.
  """

  import Ecto.Query
  alias Extra.Repo
  alias Extra.Tweeter
  alias Extra.SocialPost

  def publish_next_queued_post_for_timeslot(timeslot) do
    query = next_queued_post(timeslot)

    case Repo.one(query) do
      queued_post -> publish_queued_post(queued_post)
    end
  end

  def next_queued_post(timeslot_id) when is_integer(timeslot_id) do
    Extra.QueuedPost
    |> where(timeslot_id: ^timeslot_id)
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
    queued_post
    |> build_post
    |> Tweeter.publish_status(queued_post.channel.authorization)
    |> save_response(queued_post.channel)

    # After the post is confirmed to be published
    clean_up_queued_post(queued_post)
  end

  def build_post(queued_post) do
    %{content: queued_post.post_content.body}
  end

  def save_response(response, channel) do
    params = Tweeter.to_social_post_params(response)

    channel
    |> Ecto.build_assoc(:social_posts)
    |> SocialPost.changeset(params)
    |> Repo.insert!
  end

  def clean_up_queued_post(queued_post) do
    Repo.delete(queued_post)
  end
end
