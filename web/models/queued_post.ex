defmodule Extra.QueuedPost do
  use Extra.Web, :model
  alias Extra.SocialChannel

  schema "queued_posts" do
    field :scheduled_for, :utc_datetime
    belongs_to :channel, SocialChannel, foreign_key: :channel_id
    belongs_to :collection, Extra.Collection
    belongs_to :post_content, Extra.PostContent

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
