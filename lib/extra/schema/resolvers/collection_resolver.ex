defmodule Extra.Schema.CollectionResolver do
  @moduledoc """
  Collection Resolver for GraphQL Collection object.
  Grabs collections from the db.
  """
  alias Extra.Repo
  alias Extra.PostCollection

  def all(_args, _info) do
    {:ok, Repo.all(PostCollection)}
  end

  def find(%{id: id}, _info) do
    case Repo.get(PostCollection, id) do
      nil        -> {:error, "Collection id #{id} not found"}
      collection -> {:ok, collection}
    end
  end
end
