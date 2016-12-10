defmodule Extra.Repo.Migrations.CreateSocialChannel do
  use Ecto.Migration

  def change do
    create table(:social_channels) do
      add :name, :string
      add :image, :text
      add :provider, :string
      add :user_id, references(:users, on_delete: :nothing)

      timestamps()
    end

    create index(:social_channels, [:user_id])
  end
end
