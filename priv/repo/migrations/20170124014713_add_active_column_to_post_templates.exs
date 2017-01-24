defmodule Extra.Repo.Migrations.AddActiveColumnToPostTemplates do
  use Ecto.Migration

  def change do
    alter table(:post_templates) do
      add :active, :boolean, default: false
    end
  end
end
