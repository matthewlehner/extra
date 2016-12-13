defmodule Extra.Repo.Migrations.RenamePostsCollectionTable do
  use Ecto.Migration

  def change do
    create table(:post_collections) do
      add :name, :string
      add :user_id, references(:users, on_delete: :nothing)

      timestamps()
    end

    create index(:post_collections, [:user_id])

    drop table(:social_collections)
  end
end
