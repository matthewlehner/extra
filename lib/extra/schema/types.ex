defmodule Extra.Schema.Types do
  @moduledoc """
  Data types for the GraphQL schema
  """
  use Absinthe.Schema.Notation
  use Absinthe.Ecto, repo: Extra.Repo
  import Ecto.Query

  scalar :datetime, description: "ISOz time" do
    parse &DateTime.from_iso8601(&1.value)
    serialize &DateTime.to_iso8601(&1)
  end

  scalar :time do
    description "Time in ISO 8601 format"
    parse &Time.from_iso8601(&1.value)
    serialize &Time.to_string(&1)
  end

  # These values should be kept in sync with `Extra.RecurrenceEnum`
  enum :recurrence do
    value :monday
    value :tuesday
    value :wednesday
    value :thursday
    value :friday
    value :saturday
    value :sunday
    value :everyday
    value :weekdays
    value :weekends
  end

  object :channel do
    field :id, non_null(:id)
    field :name, non_null(:string)
    field :provider, non_null(:string)
    field :image, non_null(:string)
    field :schedule, non_null(:schedule), resolve: assoc(:schedule)
  end

  object :collection do
    field :id, non_null(:id)
    field :name, non_null(:string)
    field :posts, non_null(list_of(:post_content)), resolve: assoc(:posts, fn(query, _, _) ->
      query
      |> where([p], is_nil(p.archived_at))
    end)
  end

  object :post_content do
    field :id, non_null(:id)
    field :body, non_null(:string)
    field :collection, :collection, resolve: assoc(:collection)
    field :channels, non_null(list_of(:channel)), resolve: assoc(:channels)
  end

  object :schedule do
    field :id, non_null(:id)
    field :autopilot, non_null(:boolean)
    field :channel, non_null(:channel), resolve: assoc(:channel)
    field :timeslots, non_null(list_of(:timeslot)), resolve: assoc(:timeslots)
  end

  object :timeslot do
    field :id, non_null :id
    field :time, non_null :time
    field :recurrence, non_null :recurrence
    field :schedule, non_null(:schedule), resolve: assoc(:schedule)
    field :collection, non_null(:collection), resolve: assoc(:collection)
  end

  object :queued_post do
    field :id, non_null :id
    field :scheduled_for, non_null :datetime
    field :channel, non_null(:channel), resolve: assoc(:channel)
    field :collection, non_null(:collection), resolve: assoc(:collection)
    field :post_content, :post_content, resolve: assoc(:post_content)
  end

  object :user do
    field :id, non_null :id
    field :email, non_null :string
    field :timezone, :string
  end

  object :password_update_payload do
    field :user, :user
    field :user_errors, non_null(list_of(non_null :user_error))
  end

  object :error_object do
    description "Represents an error in the input of a mutation."

    field :field, non_null(:string),
          description: "Path to input field which caused the error"
    field :message, non_null(:string), description: "The error message"
  end

  object :user_error, do: import_fields :error_object
  object :collection_error, do: import_fields(:error_object)

  object :collection_fields do
    field :collection, :collection
    field :collection_errors, non_null(list_of(non_null(:collection_error)))
  end
  object :add_collection_payload, do: import_fields(:collection_fields)
  object :update_collection_payload, do: import_fields(:collection_fields)

end
