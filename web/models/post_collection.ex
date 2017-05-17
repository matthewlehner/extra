defmodule Extra.PostCollection do
  use Extra.Web, :model

  schema "post_collections" do
    field :name, :string
    belongs_to :user, Extra.User
    has_many :posts, Extra.PostContent
    has_many :templates, through: [:posts, :templates]

    timestamps()
  end

  def for_user(%Extra.User{} = user), do: for_user(__MODULE__, user)
  def for_user(query, user) do
    from c in query,
      where: [user_id: ^user.id]
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
