defmodule Extra.Repo.Migrations.CreateQueuedPost do
  use Ecto.Migration

  def change do
    create table(:queued_posts) do
      add :scheduled_for, :utc_datetime
      add :channel_id, references(:social_channels, on_delete: :delete_all)
      add :collection_id, references(:post_collections, on_delete: :nothing)
      add :post_content_id, references(:post_contents, on_delete: :nothing)

      timestamps()
    end

    create index(:queued_posts, [:scheduled_for])
    create index(:queued_posts, [:channel_id, :scheduled_for], unique: true)
    create index(:queued_posts, [:channel_id])
    create index(:queued_posts, [:collection_id])
    create index(:queued_posts, [:post_content_id])
  end
end
