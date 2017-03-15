defmodule Extra.Repo.Migrations.CreateSchedule do
  use Ecto.Migration

  def change do
    create table(:schedules) do
      add :autopilot, :boolean, default: true, null: false
      add :social_channel_id, references(:social_channels, on_delete: :nothing)

      timestamps()
    end
    create index(:schedules, [:social_channel_id])

  end
end
