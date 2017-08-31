defmodule Extra.Repo.Migrations.CreateExtra.SocialPost do
  use Ecto.Migration

  def change do
    create table(:posts) do
      add :content, :string
      add :platform_entity_id, :string
      add :raw_response, :map
      add :published_at, :utc_datetime
      add :social_channel_id, references(:social_channels, on_delete: :nothing)

      timestamps()
    end
    create index(:posts, [:social_channel_id])

  end
end
