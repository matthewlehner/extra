defmodule Extra.Repo.Migrations.CreatePostContent do
  use Ecto.Migration

  def change do
    create table(:post_contents) do
      add :body, :text
      add :post_collection_id, references(:post_collections, on_delete: :nothing)

      timestamps()
    end
    create index(:post_contents, [:post_collection_id])

  end
end
