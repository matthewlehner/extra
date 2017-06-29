defmodule Extra.User do
  @moduledoc """
  The User module is for storing individual user data.
  """

  use Extra.Web, :model
  import Comeonin.Bcrypt, only: [hashpwsalt: 1, checkpw: 2, dummy_checkpw: 0]

  schema "users" do
    field :full_name, :string
    field :nickname, :string
    field :email, :string
    field :timezone, :string
    field :password, :string, virtual: true
    field :password_hash, :string

    has_many :auth_tokens, Extra.AuthToken
    has_many :user_sessions, Extra.UserSession
    has_many :social_channels, Extra.SocialChannel
    has_many :post_collections, Extra.PostCollection

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, ~w(email))
    |> validate_format(:email, ~r/.+@.+\..+/)
    |> unique_constraint(:email)
  end

  def registration_changeset(struct, params \\ %{}) do
    struct
    |> changeset(params)
    |> cast(params, [:password, :email, :full_name, :nickname])
    |> validate_required([:password, :email, :full_name])
    |> validate_length(:password, min: 8)
    |> put_pass_hash()
  end

  def update_password(user, %{current: current, new: new}) do
    if checkpw(current, user.password_hash) do
      user
      |> cast(%{password: new}, ~w(password))
      |> validate_length(:password, min: 8)
      |> put_pass_hash()
      |> Extra.Repo.update
    else
      dummy_checkpw()
      {:error, "The password provided is incorrect"}
    end
  end

  # Would be nice to handle this on the PG side of things exclusively.
  # http://www.meetspaceapp.com/2016/04/12/passwords-postgresql-pgcrypto.html
  defp put_pass_hash(changeset) do
    case changeset do
      %Ecto.Changeset{valid?: true, changes: %{password: pass}} ->
        put_change(changeset, :password_hash, hashpwsalt(pass))
      _ ->
        changeset
    end
  end
end
