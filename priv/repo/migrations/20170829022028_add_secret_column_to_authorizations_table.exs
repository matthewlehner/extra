defmodule Extra.Repo.Migrations.AddSecretColumnToAuthorizationsTable do
  use Ecto.Migration

  def change do
    alter table(:authorizations) do
      add :secret, :string
    end
  end
end
