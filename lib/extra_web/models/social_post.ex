defmodule Extra.SocialPost do
  use ExtraWeb, :model

  schema "posts" do
    field :content, :string
    field :platform_entity_id, :string
    field :raw_response, :map
    field :published_at, :utc_datetime
    belongs_to :social_channel, Extra.SocialChannel

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:content, :platform_entity_id, :raw_response, :published_at, :social_channel_id])
    |> validate_required([:content, :platform_entity_id, :raw_response, :published_at])
    |> assoc_constraint(:social_channel)
  end
end
