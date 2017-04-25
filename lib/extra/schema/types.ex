defmodule Extra.Schema.Types do
  @moduledoc """
  Data types for the GraphQL schema
  """
  use Absinthe.Schema.Notation
  use Absinthe.Ecto, repo: Extra.Repo

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
    value :everyday
    value :weekdays
    value :weekends
  end

  object(:channel) do
    field :id, :id
    field :name, :string
    field :provider, :string
    field :image, :string
    field :schedule, :schedule, resolve: assoc(:schedule)
  end

  object(:collection) do
    field :id, :id
    field :name, :string
    field :posts, list_of(:post_content), resolve: assoc(:posts)
  end

  object(:post_content) do
    field :id, :id
    field :body, :string
    field :collection, :collection, resolve: assoc(:collection)
    field :channels, list_of(:channel), resolve: assoc(:channels)
  end

  object(:schedule) do
    field :id, :id
    field :autopilot, :boolean
    field :channel, :channel, resolve: assoc(:channel)
    field :timeslots, list_of(:timeslot), resolve: assoc(:timeslots)
  end

  object(:timeslot) do
    field :id, :id
    field :time, :time
    field :recurrence, :recurrence
    field :schedule, :schedule, resolve: assoc(:schedule)
    field :collection, :collection, resolve: assoc(:collection)
  end
end
