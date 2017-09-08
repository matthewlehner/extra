defmodule Extra.Schema.Resolvers.PostContent do
  @moduledoc """
  Resolver for PostContent Schema
  """

  import Ecto.Query
  import Extra.Schema.ResolverHelpers
  alias Ecto.Multi
  alias Extra.Repo
  alias Extra.PostContent
  alias Extra.PostCollection
  alias Extra.PostManager

  def get(%{id: id}, %{context: %{current_user: user}}) do
    post = get_post_content_for_user(user, id)

    case post do
      %PostContent{} -> {:ok, post}
      nil            -> {:error, "A post with id #{id} could not be found"}
    end
  end

  def create(
    %{input:
      %{body: body, collection_id: collection_id, channel_ids: channel_ids}
    },
    %{context: %{current_user: %{id: user_id}}}
  ) do

    templates = Enum.map(channel_ids, &(%{"social_channel_id" => &1}))

    changeset =
      PostCollection
    |> where(user_id: ^user_id)
    |> Repo.get!(collection_id)
    |> Ecto.build_assoc(:posts)
    |> PostContent.changeset(%{body: body, templates: templates})

    case Repo.insert(changeset) do
      {:ok, content} -> {:ok, %{content: content, content_errors: []}}
      {:error, changeset} -> {:ok, %{content_errors: errors_on(changeset)}}
    end
  end

  def create(_, _), do: {:error, "Not Authorized"}

  def archive(%{id: id}, %{context: %{current_user: user}}) do
    result = user
             |> get_post_content_for_user(id)
             |> PostManager.archive()

    case result do
      {:ok, %{post_content: content}} -> {:ok, content}
      _ -> {:error, "A post with id #{id} could not be found"}
    end
  end

  def update(%{input: content_params}, %{context: %{current_user: user}}) do
    post = get_post_content_for_user(user, content_params.id)

    case post do
      %PostContent{} -> update_post(post, content_params)
      nil            -> {:error, "A post with id #{content_params.id} could not be found"}
    end
  end

  defp get_post_content_for_user(user, id) do
    PostContent
    |> PostContent.for_user(user)
    |> Repo.get(id)
  end

  defp update_post(post, params) do
    case persist_updated_post(post, params) do
      {:ok, %{post_content: content}} -> {:ok, %{content: content, content_errors: []}}
      {:error, :post_content, changeset} -> {:ok, %{content_errors: errors_on(changeset)}}
      {:error, operation, _, _} -> {:error, "Something went wrong with the #{operation}. Try again"}
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
    |> where([p], not(p.social_channel_id in ^persisted_channel_ids))
  end

  defp insertable_templates(post, channel_ids) do
    post = Repo.preload(post, :templates)
    now = DateTime.utc_now
    channel_ids
    |> Enum.reject(fn(id) ->
      Enum.any?(post.templates, &(&1.social_channel_id == id))
    end)
    |> Enum.map(&(%{
      social_channel_id: String.to_integer(&1),
      post_content_id: post.id,
      inserted_at: now,
      updated_at: now
    }))
  end

  defp update_changeset(post, params) do
    PostContent.changeset(post, %{body: params.body})
  end
end
