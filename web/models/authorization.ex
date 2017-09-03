defmodule Extra.Authorization do
  use Extra.Web, :model

  schema "authorizations" do
    field :token, :string
    field :secret, :string
    field :refresh_token, :string
    field :expires_at, :integer
    field :scopes, {:array, :string}
    belongs_to :social_channel, Extra.SocialChannel

    timestamps(type: :utc_datetime)
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:token, :secret, :refresh_token, :expires_at])
    |> validate_required([:token, :secret])
  end
end
