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

  @spec to_datetime(%Extra.Timeslot{}) :: DateTime.t()
  def to_datetime(timeslot) do
    timeslot.recurrence
    |> Extra.Recurrence.days_of_week_for()
    |> Enum.map(&(Extra.DateHelpers.next_day(&1)))
    |> Enum.map(fn(date) ->
      {:ok, datetime} = NaiveDateTime.new(date, timeslot.time)
      datetime
    end)
  end
end
