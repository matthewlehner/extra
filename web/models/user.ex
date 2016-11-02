defmodule Extra.User do
  use Extra.Web, :model

  schema "users" do
    has_many :auth_tokens, Extra.AuthToken
    has_many :user_sessions, Extra.UserSession

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
