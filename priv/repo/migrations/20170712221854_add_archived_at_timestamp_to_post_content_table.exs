defmodule Extra.Repo.Migrations.AddArchivedAtTimestampToPostContentTable do
  use Ecto.Migration

  def change do
    alter table(:post_contents) do
      add :archived_at, :utc_datetime
    end
  end
end
