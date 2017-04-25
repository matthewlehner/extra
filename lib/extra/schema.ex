defmodule Extra.Schema do
  @moduledoc """
  GraphQL schema for Extra
  """
  use Absinthe.Schema
  alias Extra.Schema.ChannelResolver
  alias Extra.Schema.CollectionResolver
  alias Extra.Schema.Resolvers.Schedule
  alias Extra.Schema.Resolvers.Timeslot
  alias Extra.Schema.Resolvers.PostContent

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

  input_object :update_schedule_params do
    field :autopilot, non_null(:boolean)
  end

  input_object :add_timeslot_params do
    field :time, non_null(:time)
    field :recurrence, non_null(:recurrence)
  end

  mutation do
    field :update_schedule, type: :schedule do
      arg :channel_id, non_null(:id)
      arg :schedule, :update_schedule_params

      resolve &Schedule.update/2
    end

    field :add_timeslot, type: :timeslot do
      arg :schedule_id, non_null(:id)
      arg :collection_id, non_null(:id)
      arg :timeslot, :add_timeslot_params

      resolve &Timeslot.create/2
    end

    field :add_post, type: :post_content do
      arg :body, non_null(:string)
      arg :collection_id, non_null(:id)
      arg :channel_ids, list_of(:id)

      resolve &PostContent.create/2
    end
  end
end
