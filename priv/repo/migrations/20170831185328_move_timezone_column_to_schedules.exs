defmodule Extra.Repo.Migrations.MoveTimezoneColumnToSchedules do
  use Ecto.Migration

  def change do
    alter table(:users) do
      remove :timezone
    end

    alter table(:schedules) do
      add :timezone, :string, default: "America/Vancouver"
    end
  end
end
