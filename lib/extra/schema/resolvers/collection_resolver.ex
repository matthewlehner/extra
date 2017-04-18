defmodule Extra.Schema.CollectionResolver do
  @moduledoc """
  Collection Resolver for GraphQL Collection object.
  Grabs collections from the db.
  """
  import Ecto.Query, only: [where: 2]
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
    collection =
      PostCollection
      |> where(user_id: ^user_id)
      |> Repo.get(id)

    case collection do
      nil        -> {:error, "Collection id #{id} not found"}
      collection -> {:ok, collection}
    end
  end

  def find(_, _), do: {:error, "Not Authorized"}
end
