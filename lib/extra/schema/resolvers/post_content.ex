defmodule Extra.Schema.Resolvers.PostContent do
  @moduledoc """
  Resolver for PostContent Schema
  """

  import Ecto.Query
  alias Extra.Repo
  alias Extra.PostContent
  alias Extra.PostCollection

  def get(%{id: id}, %{context: %{current_user: user}}) do
    post = PostContent
           |> PostContent.for_user(user)
           |> Repo.get(id)

    case post do
      %PostContent{} -> {:ok, post}
      nil            -> {:error, "A post with id #{id} could not be found"}
    end

  end

  def create(
    %{body: body, collection_id: collection_id, channel_ids: channel_ids},
    %{context: %{current_user: %{id: user_id}}}
  ) do

    templates = Enum.map(channel_ids, &(%{"social_channel_id" => &1}))

    PostCollection
    |> where(user_id: ^user_id)
    |> Repo.get!(collection_id)
    |> Ecto.build_assoc(:posts)
    |> PostContent.changeset(%{body: body, templates: templates})
    |> Repo.insert()
  end

  def create(_, _), do: {:error, "Not Authorized"}
end
