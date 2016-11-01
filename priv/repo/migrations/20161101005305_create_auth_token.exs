defmodule Extra.Repo.Migrations.CreateAuthToken do
  use Ecto.Migration

  def change do
    create table(:auth_tokens) do
      add :token, :string
      add :uid, :string
      add :provider, :integer
      add :user_id, references(:users, on_delete: :nothing)

      timestamps()
    end

    create unique_index(:auth_tokens, [:uid])
    create index(:auth_tokens, [:user_id])
  end
end
