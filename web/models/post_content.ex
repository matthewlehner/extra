defmodule Extra.PostContent do
  use Extra.Web, :model

  schema "post_contents" do
    field :body, :string
    belongs_to :collection, Extra.PostCollection, foreign_key: :post_collection_id
    has_many :templates, Extra.PostTemplate

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:body, :post_collection_id])
    |> validate_required([:body, :post_collection_id])
  end

  def changeset_with_post_templates(struct, channels, params \\ %{}) do
    changeset(struct, params)
    |> put_assoc(:templates, build_templates(params, channels))
  end

  defp build_templates(params, channels) do
    channels
    |> Enum.map(fn(channel) -> build_assoc(channel, :templates, %{social_channel: channel}) end)
  end
end
