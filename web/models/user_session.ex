defmodule Extra.UserSession do
  use Extra.Web, :model

  schema "user_sessions" do
    field :user_agent, :string
    field :login_ip, :string
    field :last_activity_at, Ecto.DateTime
    field :last_activity_ip, :string
    belongs_to :user, Extra.User

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:user_agent, :login_ip, :last_activity_at, :last_activity_ip])
    |> validate_required([:user_id])
  end

  # conn is here to assign user_agent, last_activity_at, etc.
  def for_user(_conn, user) do
    build_assoc(user, :user_sessions)
    |> Extra.Repo.insert!
  end
end
