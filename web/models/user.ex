defmodule Extra.User do
  @moduledoc """
  The User module is for storing individual user data.
  """

  use Extra.Web, :model

  schema "users" do
    field :email, :string
    field :password, :string, virtual: true
    field :password_hash, :string

    has_many :auth_tokens, Extra.AuthToken
    has_many :user_sessions, Extra.UserSession

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, ~w(email))
    |> validate_required([:email])
    |> validate_format(:email, ~r/.+@.+\..+/)
    |> unique_constraint(:email)
  end

  def registration_changeset(struct, params \\ %{}) do
    struct
    |> changeset(params)
    |> cast(params, [:password])
    |> validate_length(:password, min: 8)
    |> validate_required([:password])
    |> put_pass_hash()
  end

  # Would be nice to handle this on the PG side of things exclusively.
  # http://www.meetspaceapp.com/2016/04/12/passwords-postgresql-pgcrypto.html
  defp put_pass_hash(changeset) do
    case changeset do
      %Ecto.Changeset{valid?: true, changes: %{password: pass}} ->
        put_change(changeset, :password_hash, Comeonin.Bcrypt.hashpwsalt(pass))
      _ ->
        changeset
    end
  end
end
