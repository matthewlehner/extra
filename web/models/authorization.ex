defmodule Extra.Authorization do
  use Extra.Web, :model

  schema "authorizations" do
    field :provider, :string
    field :uid, :string
    field :token, :string
    field :refresh_token, :string
    field :expires_at, :integer
    field :scopes, {:array, :string}
    belongs_to :social_channel, Extra.SocialChannel

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:provider, :uid, :token, :refresh_token, :expires_at])
    |> validate_required([:provider, :uid, :token])
    |> unique_constraint(:uid, name: :authorizations_provider_uid_index)
  end
end
