defmodule Extra.Timeslot do
  @moduledoc """
  Timeslot schema. Used for adding timeslots to a schedule, and associating
  them with collections.
  """
  use Extra.Web, :model

  schema "timeslots" do
    field :time, :time
    field :recurrence, Extra.RecurrenceEnum
    belongs_to :schedule, Extra.Schedule
    belongs_to :collection, Extra.PostCollection

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:time, :recurrence, :collection_id])
    |> validate_required([:time, :recurrence, :collection_id])
  end
end
