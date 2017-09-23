defmodule Extra.QueuedPost do
  @moduledoc """
  Schema for queued posts. Persistence for BG jobs. Kinda dumb, but necessary,
  for now.
  """
  use ExtraWeb, :model
  alias Extra.Timeslot
  alias Extra.PostTemplate

  schema "queued_posts" do
    field :scheduled_for, :utc_datetime
    belongs_to :timeslot, Timeslot
    has_one :channel, through: [:timeslot, :channel]
    has_one :collection, through: [:timeslot, :collection]
    belongs_to :post_template, PostTemplate
    has_one :post_content, through: [:post_template, :post_content]

    timestamps()
  end

  def for_user(query, user) do
    from p in query,
      join: c in assoc(p, :channel),
      where: c.user_id == ^user.id
  end

  def with_empty_content(query \\ __MODULE__) do
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

  @spec for_timeslot(%Timeslot{}) :: list(%{})
  def for_timeslot(timeslot) do
    now = DateTime.utc_now
    next_week = Timex.shift(now, weeks: 1)
    timeslot = Extra.Repo.preload(timeslot, :schedule)
    timezone = timeslot.schedule.timezone

    timeslot
    |> Timeslot.to_cron_expression()
    |> Crontab.Scheduler.get_next_run_dates()
    |> Stream.take_while(fn(datetime) ->
      Timex.compare(next_week, datetime) > 0
    end)
    |> Stream.map(fn(datetime) ->
      %{
        scheduled_for: set_timezone_time(datetime, timezone),
        timeslot_id: timeslot.id,
        inserted_at: now,
        updated_at: now
      }
    end)
    |> Enum.to_list()
  end

  defp set_timezone_time(datetime, timezone) do
    datetime
    |> Timex.to_datetime(timezone) # Returns a datetime with scheduled timezone
    |> Timex.to_datetime("Etc/UTC") # Shifts datetime to when it will happen in UTC
  end
end
