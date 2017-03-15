defmodule Extra.SocialChannel do
  use Extra.Web, :model

  schema "social_channels" do
    field :name, :string
    field :image, :string
    field :provider, :string
    has_one :authorization, Extra.Authorization
    belongs_to :user, Extra.User
    has_many :templates, Extra.PostTemplate
    has_one :schedule, Extra.Schedule

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:name, :image, :provider, :user_id])
    |> validate_required([:name, :provider])
    |> cast_assoc(:authorization, required: true)
    |> assoc_constraint(:user)
  end

  def changeset_from_auth(auth, %Extra.User{id: user_id}) do
    params = auth
             |> to_channel_params()
             |> Map.put(:user_id, user_id)

    changeset(%Extra.SocialChannel{}, params)
  end

  defp to_channel_params(%Ueberauth.Auth{provider: :twitter} = auth) do
    %{
      name: auth.info.nickname,
      image: auth.info.image,
      provider: to_string(auth.provider),
      authorization: %{
        provider: to_string(auth.provider),
        uid: auth.uid,
        token: to_string(auth.credentials.token)
      }
    }
  end
end
