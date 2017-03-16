defmodule Extra.Schedule do
  @moduledoc """
  A schedule for publishing posts.
  """
  use Extra.Web, :model

  schema "schedules" do
    field :autopilot, :boolean, default: true
    belongs_to :channel, Extra.SocialChannel, foreign_key: :social_channel_id

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:autopilot])
    |> validate_required([:autopilot])
  end
end
