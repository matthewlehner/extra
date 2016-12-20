defmodule Extra.Repo.Migrations.CreatePostTemplate do
  use Ecto.Migration

  def change do
    create table(:post_templates) do
      add :social_channel_id, references(:social_channels, on_delete: :nothing)
      add :post_content_id, references(:post_contents, on_delete: :nothing)

      timestamps()
    end
    create index(:post_templates, [:social_channel_id])
    create index(:post_templates, [:post_content_id])

  end
end
