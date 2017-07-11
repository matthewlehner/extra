defmodule Extra.Schema.Resolvers.PostContent do
  @moduledoc """
  Resolver for PostContent Schema
  """

  require Ecto.Query
  alias Ecto.Multi
  alias Extra.Repo
  alias Extra.PostContent
  alias Extra.PostCollection

  def get(%{id: id}, %{context: %{current_user: user}}) do
    post = get_post_content_for_user(user, id)

    case post do
      %PostContent{} -> {:ok, post}
      nil            -> {:error, "A post with id #{id} could not be found"}
    end
  end

  def update(%{input: content_params}, %{context: %{current_user: user}}) do
    post = get_post_content_for_user(user, content_params.id)

    case post do
      %PostContent{} -> update_post(post, content_params)
      nil            -> {:error, "A post with id #{content_params.id} could not be found"}
    end
  end

  def create(
    %{body: body, collection_id: collection_id, channel_ids: channel_ids},
    %{context: %{current_user: %{id: user_id}}}
  ) do

    templates = Enum.map(channel_ids, &(%{"social_channel_id" => &1}))

    PostCollection
    |> Ecto.Query.where(user_id: ^user_id)
    |> Repo.get!(collection_id)
    |> Ecto.build_assoc(:posts)
    |> PostContent.changeset(%{body: body, templates: templates})
    |> Repo.insert()
  end

  def create(_, _), do: {:error, "Not Authorized"}

  defp get_post_content_for_user(user, id) do
    PostContent
    |> PostContent.for_user(user)
    |> Repo.get(id)
  end

  defp update_post(post, params) do
    case persist_updated_post(post, params) do
      {:ok, %{post_content: post_content}} -> {:ok, post_content}
    end
  end

  defp persist_updated_post(post, params) do
    Multi.new
    |> Multi.update(:post_content, update_changeset(post, params))
    |> Multi.delete_all(:deleted_templates, deletable_templates(post, params.channel_ids))
    |> Multi.insert_all(:inserted_templates, Extra.PostTemplate, insertable_templates(post, params.channel_ids))
    |> Repo.transaction()
  end

  defp deletable_templates(post, persisted_channel_ids) do
    post
    |> Ecto.assoc(:templates)
    |> Ecto.Query.where([p], not(p.social_channel_id in ^persisted_channel_ids))
  end

  defp insertable_templates(post, channel_ids) do
    post = Repo.preload(post, :templates)
    now = DateTime.utc_now
    channel_ids
    |> Enum.reject(fn(id) ->
      Enum.any?(post.templates, &(&1.social_channel_id == id))
    end)
    |> Enum.map(&(%{
      social_channel_id: &1,
      post_content_id: post.id,
      inserted_at: now,
      updated_at: now
    }))
  end

  defp update_changeset(post, params) do
    PostContent.changeset(post, %{body: params.body})
  end
end
