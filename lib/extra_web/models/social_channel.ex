defmodule Extra.SocialChannel do
  @moduledoc """
  Publishing channels for Extra.
  """

  use Extra.Web, :model
  alias Extra.Authorization

  schema "social_channels" do
    field :name, :string
    field :image, :string
    field :provider, :string
    field :uid, :string
    has_one :authorization, Authorization, on_replace: :update
    belongs_to :user, Extra.User
    has_many :templates, Extra.PostTemplate
    has_one :schedule, Extra.Schedule

    has_many :queued_posts, Extra.QueuedPost
    has_many :social_posts, Extra.SocialPost

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, %Ueberauth.Auth{} = auth),
    do: changeset(struct, to_channel_params(auth))

  def changeset(%{__meta__: %{state: :built}} = struct, params) do
    struct
    |> cast(params, [:name, :image, :provider, :uid])
    |> validate_required([:name, :provider, :uid])
    |> cast_assoc(:authorization, required: true)
    |> cast_assoc(:schedule, required: true)
    |> assoc_constraint(:user)
  end

  def changeset(%{__meta__: %{state: :loaded}} = struct, params) do
    struct
    |> cast(params, [:name, :image])
    |> cast_assoc(:authorization, with: &Authorization.changeset/2)
  end

  defp to_channel_params(%Ueberauth.Auth{provider: :twitter} = auth) do
    %{
      name: auth.info.nickname,
      image: auth.info.image,
      provider: to_string(auth.provider),
      uid: auth.uid,
      authorization: %{
        token: to_string(auth.credentials.token),
        secret: to_string(auth.credentials.secret)
      },
      schedule: %{}
    }
  end
end
