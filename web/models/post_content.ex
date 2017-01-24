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
    |> cast_assoc(:templates)
  end

  def with_channel_templates(changeset, channels) do
    changeset
    |> put_assoc(:templates, build_templates(channels))
  end

  defp build_templates(channels) do
    channels
    |> Enum.map(&build_template/1)
  end

  defp build_template(channel) do
    build_assoc(channel, :templates, %{social_channel: channel})
  end
end
