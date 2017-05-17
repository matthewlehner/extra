defmodule Extra.PostPicker do
  @moduledoc """
  Contains functions related to filling empty QueuedPost structs.
  """
  import Ecto.Query

  alias Extra.Repo
  alias Extra.QueuedPost
  alias Extra.PostTemplate
  alias Extra.PostCollection

  def fill_empty_queue_slots do
    fetch_queued_posts()
    |> group_by_collection()
    |> weight_posts()
    |> assign_posts_to_queue_slots()
    |> persist_posts()

    # empty_post
    # |> QueuedPost.changeset(%{post_template_id: template.id})
    # |> Repo.update
  end

  @spec fetch_queued_posts() :: [%QueuedPost{}]
  def fetch_queued_posts do
    QueuedPost
    |> order_by(asc: :scheduled_for)
    |> with_associated_entities()
    |> Repo.all()
  end

  @spec group_by_collection([%QueuedPost{}]) :: [{%PostCollection{}, [%QueuedPost{}]}]
  def group_by_collection(queued_posts) do
    queued_posts
    |> Enum.group_by(&(&1.collection))
    |> Map.to_list()
  end

  @spec weight_posts([{%PostCollection{}, [%QueuedPost{}]}]) :: [{{:weight, [any]}, [%QueuedPost{}]}]
  def weight_posts(grouped_posts) do
    Enum.map(grouped_posts, fn {collection, queued_posts} ->
      {weight_templates(collection.templates), queued_posts}
    end)
  end

  @spec weight_templates([%PostTemplate{}]) :: {:weight, [any]}
  def weight_templates(templates) do
    templates
    |> Enum.reduce(%{}, fn(template, acc) ->
      weight = PostTemplate.weight_for(template)
      Map.put(acc, template.id, weight)
    end)
    |> Extra.WeightedChoice.resource()
  end

  @spec assign_posts_to_queue_slots([{{:weight, [any]}, [%QueuedPost{}]}]) :: []
  def assign_posts_to_queue_slots(posting_data) do
    Enum.reduce(posting_data, [], &prepare_changesets/2)
  end

  def persist_posts(changesets), do: Enum.each(changesets, &(Repo.update(&1)))

  def prepare_changesets({resource, posts}, changesets) do
    Enum.reduce(posts, changesets, fn(post, acc) ->
      case post.post_template_id do
        nil -> List.insert_at(acc, -1, template_changeset(post, resource))
        _   -> acc
      end
    end)
  end

  def template_changeset(post, resource) do
    choice = Extra.WeightedChoice.choice(resource)
    QueuedPost.changeset(post, %{post_template_id: choice})
  end

  def with_associated_entities(query) do
    from post in query,
      join: collection in assoc(post, :collection),
      join: post_template in assoc(collection, :templates),
      # join: post_content in assoc(post_template, :post_content),
      preload: [
        collection: {collection, templates: post_template}
      ]
  end
end

# defstruct [:post_templates, :collection, :queue_slots, :selected_templates]
