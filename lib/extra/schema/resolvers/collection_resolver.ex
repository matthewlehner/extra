defmodule Extra.Schema.CollectionResolver do
  @moduledoc """
  Collection Resolver for GraphQL Collection object.
  Grabs collections from the db.
  """
  import Ecto.Query, only: [where: 2]
  import Extra.Schema.ResolverHelpers
  alias Extra.Repo
  alias Extra.PostCollection

  def all(_args, %{context: %{current_user: %{id: id}}}) do
    collections =
      PostCollection
      |> where(user_id: ^id)
      |> Repo.all

    {:ok, collections}
  end

  def all(_args, _info), do: {:error, "Not Authorized"}

  def find(%{id: id}, %{context: %{current_user: %{id: user_id}}}) do
    queryable = PostCollection
                |> where(user_id: ^user_id)

    case Repo.get(queryable, id) do
      nil        -> {:error, "Collection id #{id} not found"}
      collection -> {:ok, collection}
    end
  end

  def find(_, _), do: {:error, "Not Authorized"}

  def create(%{input: params}, %{context: %{current_user: user}}) do
    changeset = user
                |> Ecto.build_assoc(:post_collections)
                |> PostCollection.changeset(params)

    case Repo.insert(changeset) do
      {:ok, collection} -> {:ok, %{collection: collection, collection_errors: []}}
      {:error, changeset} -> {:ok, %{collection_errors: errors_on(changeset)}}
    end
  end
end
