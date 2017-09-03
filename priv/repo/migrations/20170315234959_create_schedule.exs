defmodule Extra.Repo.Migrations.CreateSchedule do
  use Ecto.Migration
  import Ecto.Query

  def change do
    create table(:schedules) do
      add :autopilot, :boolean, default: true, null: false
      add :social_channel_id, references(:social_channels, on_delete: :nothing), null: false

      timestamps()
    end
    create index(:schedules, [:social_channel_id], unique: true)

    if direction() == :up do
      flush()

      schedules = from(c in "social_channels",
                       select: %{social_channel_id: c.id})
                  |> Extra.Repo.all()
      Extra.Repo.insert_all("schedules", schedules)
    end
  end
end
