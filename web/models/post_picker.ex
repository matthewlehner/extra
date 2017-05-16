defmodule Extra.PostPicker do
  import Ecto.Query

  alias Extra.Repo
  alias Extra.QueuedPost
  alias Extra.PostTemplate

  def fill_empty_queue_slots do
    # fetch_empty_posts()
    # |> assign_content_to_posts

    empty_posts = fetch_empty_posts()
    empty_post = Enum.fetch!(empty_posts, 0)
    potential_templates = potential_templates_for_timeslot(empty_post.timeslot)

    template = choose_template(potential_templates)

    empty_post
    |> QueuedPost.changeset(%{post_template_id: template.id})
    |> Repo.update
  end

  def fetch_empty_posts do
    QueuedPost.with_empty_content()
    |> order_by(asc: :scheduled_for)
    |> with_timeslots()
    |> Repo.all()
  end

  def choose_template(potential_templates) do
    Enum.random(potential_templates)
  end

  def potential_templates_for_timeslot(timeslot) do
    query = from template in PostTemplate,
      join: channel in assoc(template, :social_channel),
      where: channel.id == ^timeslot.schedule.social_channel_id

    Repo.all(query)
  end

  def with_timeslots(query) do
    from post in query,
      preload: [:post_template, timeslot: :schedule]
  end
end
