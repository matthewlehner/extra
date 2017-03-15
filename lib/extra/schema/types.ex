defmodule Extra.Schema.Types do
  @moduledoc """
  Data types for the GraphQL schema
  """
  use Absinthe.Schema.Notation
  use Absinthe.Ecto, repo: Extra.Repo

  object(:channel) do
    field :id, :id
    field :name, :string
    field :provider, :string
    field :image, :string
  end

  object(:collection) do
    field :id, :id
    field :name, :string
    field :posts, list_of(:post), resolve: assoc(:posts)
  end

  object(:post) do
    field :id, :id
    field :body, :string
    field :collection, :collection
  end
end
