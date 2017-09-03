defmodule Extra.Repo.Migrations.AddUidToSocialChannelsTable do
  use Ecto.Migration
  import Ecto.Query

  def up do
    alter table(:social_channels) do
      add :uid, :string
    end

    create index(:social_channels, [:uid])
    create unique_index(:social_channels, [:uid, :user_id])

    flush()

    from(c in "social_channels",
         join: a in "authorizations", on: [social_channel_id: c.id],
         update: [set: [uid: a.uid]])
    |> Extra.Repo.update_all([])

    alter table(:authorizations) do
      remove :uid
      remove :provider
    end
  end

  def down do
    alter table(:authorizations) do
      add :provider, :string
      add :uid, :string
    end

    create unique_index(:authorizations, [:provider, :uid])
    create index(:authorizations, [:provider, :token])

    flush()
    from(a in "authorizations",
         join: c in "social_channels", on: [id: a.social_channel_id],
         update: [set: [uid: c.uid, provider: c.provider]])
    |> Extra.Repo.update_all([])


    alter table(:social_channels) do
      remove :uid
    end
  end
end
