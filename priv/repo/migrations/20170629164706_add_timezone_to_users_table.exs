defmodule Extra.Repo.Migrations.AddTimezoneToUsersTable do
  use Ecto.Migration

  def change do
    alter table(:users) do
      add :timezone, :string
    end
  end
end
