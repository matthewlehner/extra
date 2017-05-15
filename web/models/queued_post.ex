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

  def upcoming(query \\ Extra.Post) do
    from p in query,
    where: p.scheduled_for > ^DateTime.utc_now()
  end

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
    |> cast(params, [:scheduled_for])
    |> validate_required([:scheduled_for])
  end
end
