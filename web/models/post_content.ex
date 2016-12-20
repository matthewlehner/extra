defmodule Extra.PostContent do
  use Extra.Web, :model

  schema "post_contents" do
    field :body, :string
    belongs_to :post_collection, Extra.PostCollection
    has_many :post_templates, Extra.PostTemplate

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:body])
    |> validate_required([:body])
  end
end
