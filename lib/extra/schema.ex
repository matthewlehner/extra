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
  alias Extra.Schema.Resolvers.QueuedPostResolver
  alias Extra.Schema.Resolvers.UserResolver

  import_types Extra.Schema.Types

  query do
    field :channels, list_of(:channel) do
      resolve &ChannelResolver.all/2
    end

    field :channel, :channel do
      arg :id, non_null(:id)
      resolve &ChannelResolver.find/2
    end

    field :collections, list_of(:collection) do
      resolve &CollectionResolver.all/2
    end

    field :collection, :collection do
      arg :id, non_null(:id)
      resolve &CollectionResolver.find/2
    end

    field :schedule, :schedule do
      arg :channel_id, non_null(:id)
      resolve &Schedule.find_by/3
    end

    field :queued_posts, list_of(:queued_post) do
      arg :channel_id, non_null(:id)
      resolve &QueuedPostResolver.for_channel/3
    end

    field :post_content, :post_content do
      arg :id, non_null(:id)
      resolve &PostContent.get/2
    end

    field :user_preferences, :user do
      resolve &UserResolver.get/2
    end
  end

  input_object :update_schedule_params do
    field :autopilot, non_null(:boolean)
  end

  input_object :add_timeslot_params do
    field :time, non_null(:time)
    field :recurrence, non_null(:recurrence)
    field :schedule_id, non_null(:id)
    field :collection_id, non_null(:id)
  end

  input_object :password_params do
    field :current, non_null(:string)
    field :new, non_null(:string)
  end

  input_object :user_params do
    field :email, :string
    field :timezone, :string
  end

  input_object :update_post_content_payload do
    field :id, non_null(:id)
    field :body, non_null(:string)
    field :channel_ids, non_null(list_of(:id))
  end

  mutation do
    description "The schema’s entry-point for mutations. This acts as the public, top-level API from which all mutation queries must start."

    field :update_schedule, :schedule do
      arg :channel_id, non_null(:id)
      arg :schedule, :update_schedule_params

      resolve &Schedule.update/2
    end

    field :add_timeslot, :timeslot do
      arg :timeslot, :add_timeslot_params

      resolve &Timeslot.create/2
    end

    field :remove_timeslot, :timeslot do
      arg :id, non_null(:id)

      resolve &Timeslot.remove/2
    end

    field :add_post, :post_content do
      arg :body, non_null(:string)
      arg :collection_id, non_null(:id)
      arg :channel_ids, list_of(:id)

      resolve &PostContent.create/2
    end

    field :update_post_content, :post_content do
      arg :input, non_null(:update_post_content_payload)

      resolve &PostContent.update/2
    end

    field :archive_post_content, :post_content do
      arg :id, non_null(:id)

      resolve &PostContent.archive/2
    end

    field :update_password, non_null(:password_update_payload) do
      arg :input, non_null(:password_params)

      resolve &UserResolver.update_password/2
    end

    field :update_preferences, :user do
      arg :input, non_null(:user_params)

      resolve &UserResolver.update/2
    end
  end
end
