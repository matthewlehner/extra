defmodule Extra.Repo.Migrations.CreateUserSession do
  use Ecto.Migration

  def change do
    create table(:user_sessions) do
      add :user_agent, :string
      add :login_ip, :string
      add :last_activity_at, :datetime
      add :last_activity_ip, :string
      add :user_id, references(:users, on_delete: :nothing)

      timestamps()
    end
    create index(:user_sessions, [:user_id])

  end
end
