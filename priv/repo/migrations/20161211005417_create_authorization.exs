defmodule Extra.Repo.Migrations.CreateAuthorization do
  use Ecto.Migration

  def change do
    create table(:authorizations) do
      add :provider, :string
      add :uid, :string
      add :token, :string
      add :refresh_token, :string
      add :expires_at, :bigint
      add :scopes, {:array, :string}, default: []
      add :social_channel_id, references(:social_channels, on_delete: :nothing)

      timestamps()
    end

    create unique_index(:authorizations, [:provider, :uid])
    create index(:authorizations, [:provider, :token])
    create index(:authorizations, [:social_channel_id])
  end
end
