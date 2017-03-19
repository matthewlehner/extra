defmodule Extra.Repo.Migrations.CreateTimeslot do
  use Ecto.Migration

  def change do
    create table(:timeslots) do
      add :time, :time, null: false
      add :recurrence, :integer, null: false
      add :schedule_id, references(:schedules, on_delete: :nothing), null: false
      add :collection_id, references(:post_collections, on_delete: :nothing), null: false

      timestamps()
    end
    create index(:timeslots, [:schedule_id])
    create index(:timeslots, [:collection_id])

  end
end
