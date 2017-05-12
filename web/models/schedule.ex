defmodule Extra.Schedule do
  @moduledoc """
  A schedule for publishing posts.
  """
  use Extra.Web, :model

  schema "schedules" do
    field :autopilot, :boolean, default: true
    belongs_to :channel, Extra.SocialChannel, foreign_key: :social_channel_id
    has_many :timeslots, Extra.Timeslot

    timestamps()
  end

  def for_user(%Extra.User{} = user), do: for_user(__MODULE__, user)

  def for_user(query, user) do
    from p in query,
      join: c in assoc(p, :channel),
      where: c.user_id == ^user.id
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:autopilot])
  end

  def build_queue(schedule) do
    schedule
    |> Repo.preload(:timeslots)
    |> Map.fetch!(:timeslots)
  end
end
