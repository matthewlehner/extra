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

  @spec build_post_queue(%Extra.Timeslot{}) :: DateTime.t()
  def build_post_queue(timeslot) do
    timeslot = Extra.Repo.preload(timeslot, :schedule)
    now = DateTime.utc_now

    timeslot
    |> Map.fetch!(:recurrence)
    |> Extra.Recurrence.days_of_week_for()
    |> Enum.map(&(Extra.DateHelpers.next_day(&1)))
    |> Enum.map(fn(date) ->
      {:ok, datetime} = NaiveDateTime.new(date, timeslot.time)
      DateTime.from_naive!(datetime, "Etc/UTC")
    end)
    |> Enum.map(fn(datetime) ->
      %{
        scheduled_for: datetime,
        channel_id: timeslot.schedule.social_channel_id,
        collection_id: timeslot.collection_id,
        inserted_at: now,
        updated_at: now
      }
    end)
    |> insert_posts
  end

  defp insert_posts(posts) do
    Extra.Repo.insert_all(Extra.Post, posts, on_conflict: :nothing)
  end
end
