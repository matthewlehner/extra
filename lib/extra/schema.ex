defmodule Extra.Schema do
  @moduledoc """
  GraphQL schema for Extra
  """
  use Absinthe.Schema
  alias Extra.Schema.{ChannelResolver, CollectionResolver}
  alias Extra.Schema.Resolvers.Schedule

  import_types Extra.Schema.Types

  query do
    field :channels, list_of(:channel) do
      resolve &ChannelResolver.all/2
    end

    field :channel, type: :channel do
      arg :id, non_null(:id)
      resolve &ChannelResolver.find/2
    end

    field :collections, list_of(:collection) do
      resolve &CollectionResolver.all/2
    end

    field :collection, type: :collection do
      arg :id, non_null(:id)
      resolve &CollectionResolver.find/2
    end

    field :schedule, type: :schedule do
      arg :channel_id, non_null(:id)
      resolve &Schedule.find_by/3
    end
  end
end
