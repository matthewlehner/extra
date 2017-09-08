defmodule Extra.UserSession do
  @moduledoc """
  User Session is used for individual device sessions. Users have many sessions
  which can be invalidated.
  """
  use ExtraWeb, :model

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
    user
    |> build_assoc(:user_sessions)
    |> Extra.Repo.insert!
  end
end
