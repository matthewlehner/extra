defmodule Extra.AuthToken do
  use ExtraWeb, :model

  @moduledoc """
  Provides storage for other application authorization tokens.
  """

  schema "auth_tokens" do
    field :token, :string
    field :uid, :string
    field :provider, ProviderEnum
    belongs_to :user, Extra.User

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:token, :uid, :provider])
    |> validate_required([:token, :uid])
    |> unique_constraint(:uid)
  end
end
