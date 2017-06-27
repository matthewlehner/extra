defmodule Extra.Timeslot do
  @moduledoc """
  Timeslot schema. Used for adding timeslots to a schedule, and associating
  them with collections.
  """
  use Extra.Web, :model
  alias Extra.Schedule

  schema "timeslots" do
    field :time, :time
    field :recurrence, Extra.RecurrenceEnum
    belongs_to :schedule, Schedule
    has_one :channel, through: [:schedule, :channel]
    belongs_to :collection, Extra.PostCollection

    timestamps()
  end

  @doc """
  Scopes timeslots to user.
  """
  @spec for_user(Ecto.Query.t, %Extra.User{}) :: Ecto.Query.t
  def for_user(query, user) do
    from t in query,
      join: c in assoc(t, :collection),
      where: c.user_id == ^user.id
  end


  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:time, :recurrence, :collection_id, :schedule_id])
    |> validate_required([:time, :recurrence, :collection_id, :schedule_id])
    |> foreign_key_constraint(:schedule_id)
    |> foreign_key_constraint(:collection_id)
  end

  def changeset_for_user(struct, params, user) do
    struct
    |> changeset(params)
    |> validate_collection_user(user)
    |> validate_schedule_user(user)
  end

  def validate_schedule_user(changeset, user) do
    validate_change changeset, :schedule_id, fn _, schedule_id ->
      schedule = user
                 |> Schedule.for_user()
                 |> Extra.Repo.get(schedule_id)

      case schedule do
        %Schedule{} -> []
        nil               -> [schedule_id: "not found"]
      end
    end
  end

  def validate_collection_user(changeset, user) do
    validate_change changeset, :collection_id, fn _, collection_id ->
      collection = user
                   |> Extra.PostCollection.for_user()
                   |> Extra.Repo.get(collection_id)

      case collection do
        %Extra.PostCollection{} -> []
        nil                     -> [collection_id: "not found"]
      end
    end
  end

  @spec build_post_queue(%Extra.Timeslot{}) :: DateTime.t()
  def build_post_queue(timeslot) do
    Extra.SchedulerRegistry.add_job(Extra.SchedulerRegistry, timeslot)
    timeslot
    |> Extra.QueuedPost.for_timeslot()
    |> insert_posts
  end

  defp insert_posts(posts) do
    Extra.Repo.insert_all(Extra.QueuedPost, posts, on_conflict: :nothing)
  end

  @spec to_cron_expression(%__MODULE__{}) :: Crontab.CronExpression.t
  def to_cron_expression(timeslot) do
    %Crontab.CronExpression{
      hour: [timeslot.time.hour],
      minute: [timeslot.time.minute],
      weekday: Extra.Recurrence.cron_weekday(timeslot.recurrence)
    }
  end
end
