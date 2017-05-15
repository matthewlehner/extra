defmodule Extra.Repo.Migrations.CreateQueuedPost do
  use Ecto.Migration

  def change do
    create table(:queued_posts) do
      add :scheduled_for, :utc_datetime
      add :timeslot_id, references(:timeslots, on_delete: :delete_all)
      add :post_template_id, references(:post_templates, on_delete: :nilify_all)

      timestamps()
    end

    create index(:queued_posts, [:timeslot_id, :scheduled_for], unique: true)
    create index(:queued_posts, [:post_template_id])
  end
end
