defmodule Extra.Repo.Migrations.CreateSchedule do
  use Ecto.Migration

  def change do
    create table(:schedules) do
      add :autopilot, :boolean, default: true, null: false
      add :social_channel_id, references(:social_channels, on_delete: :nothing), null: false

      timestamps()
    end
    create index(:schedules, [:social_channel_id], unique: true)

    if direction() == :up do
      flush()
      Extra.SocialChannel
      |> Extra.Repo.all
      |> Enum.map(&Ecto.build_assoc(&1, :schedule))
      |> Enum.each(&Extra.Repo.insert(&1))
    end
  end
end
