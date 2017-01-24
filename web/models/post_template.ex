defmodule Extra.PostTemplate do
  use Extra.Web, :model

  schema "post_templates" do
    # Rather than having this column, it'll be better to just delete the post
    # template record.
    # http://blog.plataformatec.com.br/2015/08/working-with-ecto-associations-and-embeds/
    field :active, :boolean, default: false
    belongs_to :social_channel, Extra.SocialChannel
    belongs_to :post_content, Extra.PostContent

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:social_channel_id, :active])
    |> validate_required([:social_channel_id, :post_content_id])
    |> assoc_constraint(:social_channel)
    |> assoc_constraint(:post_content)
  end
end
