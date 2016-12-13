defmodule Extra.Repo.Migrations.CreateSocialCollection do
  use Ecto.Migration

  def change do
    create table(:social_collections) do
      add :name, :string
      add :user_id, references(:users, on_delete: :nothing)

      timestamps()
    end
    create index(:social_collections, [:user_id])

  end
end
