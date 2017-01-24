defmodule Extra.PostTemplate do
  use Extra.Web, :model

  schema "post_templates" do
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
    |> cast(params, [])
    |> validate_required([])
  end
end
