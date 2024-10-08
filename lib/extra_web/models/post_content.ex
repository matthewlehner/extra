defmodule Extra.PostContent do
  use ExtraWeb, :model

  schema "post_contents" do
    field :body, :string
    field :archived_at, :utc_datetime
    belongs_to :collection, Extra.PostCollection, foreign_key: :post_collection_id
    has_many :templates, Extra.PostTemplate
    has_many :channels, through: [:templates, :social_channel]
    has_many :queued_posts, through: [:templates, :queued_posts]

    timestamps()
  end

  @doc """

  """
  @spec for_user(Ecto.Queryable.t, %Extra.User{}) :: Ecto.Queryable.t
  def for_user(query \\ __MODULE__, user) do
    from p in query,
      join: c in assoc(p, :collection),
      where: c.user_id == ^user.id
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

  @doc """
  Builds a collection of templates for PostTemplates that do not exist
  for the SocialChannel related to the post itself.
  """
  def build_potential_templates(post, channels) do
    {:ok, templates} = post
                       |> Extra.Repo.preload(:templates)
                       |> Map.fetch(:templates)

    channels
    |> filter_associated_channels(templates)
    |> Enum.map(&build_template/1)
  end

  defp filter_associated_channels(channels, templates) do
    Enum.reject channels, fn(channel) ->
      Enum.find(templates, &(&1.social_channel_id == channel.id))
    end
  end

  defp build_template(channel) do
    build_assoc(channel, :templates, %{social_channel: channel})
  end

  @spec archive_changeset(%__MODULE__{}) :: {:ok, %__MODULE__{}} | {:error, Ecto.Changeset.t()}
  def archive_changeset(content) do
    content
    |> cast(%{archived_at: DateTime.utc_now()}, [:archived_at])
    |> validate_required([:archived_at])
  end
end
