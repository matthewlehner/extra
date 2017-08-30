defmodule Extra.SocialPost do
  use Extra.Web, :model

  schema "posts" do
    field :content, :string
    field :channel_post_id, :string
    field :response, :map
    field :published_at, :utc_datetime
    belongs_to :social_channel, Extra.SocialChannel

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:content, :channel_post_id, :response, :published_at])
    |> validate_required([:content, :channel_post_id, :response, :published_at])
    |> unique_constraint(:channel_post_id)
  end
end
