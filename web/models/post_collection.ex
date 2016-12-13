defmodule Extra.PostCollection do
  use Extra.Web, :model

  schema "post_collections" do
    field :name, :string
    belongs_to :user, Extra.User

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:name, :user_id])
    |> validate_required([:name])
    |> assoc_constraint(:user)
  end
end
