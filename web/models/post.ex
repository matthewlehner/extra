defmodule Extra.Post do
  use Extra.Web, :model

  schema "posts" do
    field :scheduled_for, :utc_datetime
    belongs_to :channel, Extra.SocialChannel
    belongs_to :collection, Extra.Collection
    belongs_to :post_content, Extra.PostContent

    timestamps()
  end

  def upcoming(query \\ Post) do
    from p in query,
    where: p.scheduled_for > ^DateTime.utc_now()
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
