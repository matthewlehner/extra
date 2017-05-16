defmodule Extra.QueuedPost do
  @moduledoc """
  Schema for queued posts. Persistence for BG jobs. Kinda dumb, but necessary,
  for now.
  """
  use Extra.Web, :model

  schema "queued_posts" do
    field :scheduled_for, :utc_datetime
    belongs_to :timeslot, Extra.Timeslot
    has_one :channel, through: [:timeslot, :channel]
    has_one :collection, through: [:timeslot, :collection]
    belongs_to :post_template, Extra.PostTemplate
    has_one :post_content, through: [:post_template, :post_content]

    timestamps()
  end

  def for_user(query, user) do
    from p in query,
      join: c in assoc(p, :channel),
      where: c.user_id == ^user.id
  end

  def with_empty_content(query \\ Extra.QueuedPost) do
    from p in query, where: is_nil(p.post_template_id)
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:scheduled_for, :post_template_id])
    |> validate_required([:scheduled_for, :post_template_id])
  end

  @spec for_timeslot(%Extra.Timeslot{}) :: list(%{})
  def for_timeslot(timeslot) do
    now = DateTime.utc_now

    timeslot
    |> Map.fetch!(:recurrence)
    |> Extra.Recurrence.days_of_week_for()
    |> Enum.map(fn(day) ->
      date = Extra.DateHelpers.next_day(day)
      {:ok, datetime} = NaiveDateTime.new(date, timeslot.time)
      DateTime.from_naive!(datetime, "Etc/UTC")
    end)
    |> Enum.sort_by(&DateTime.to_unix/1)
    |> Enum.map(fn(datetime) ->
      %{
        scheduled_for: datetime,
        timeslot_id: timeslot.id,
        inserted_at: now,
        updated_at: now
      }
    end)
  end
end
