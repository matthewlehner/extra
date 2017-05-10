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

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    cast(struct, params, [:autopilot])
  end

  def build_queue(schedule) do
    timeslots = schedule
    |> Repo.preload(:timeslots)
    |> Map.fetch!(:timeslots)
  end
end
