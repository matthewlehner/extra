defmodule Extra.QueuedPostTest do
  use Extra.ModelCase, async: true

  import Ecto.Query
  alias Extra.QueuedPost
  alias Extra.Repo

  @valid_attrs %{scheduled_for:
    Timex.to_datetime(%{
      day: 17, hour: 14, min: 0, month: 4, sec: 0, year: 2010
    }),
    post_template_id: 1
  }

  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = QueuedPost.changeset(%QueuedPost{}, @valid_attrs)
    assert changeset.errors == []
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = QueuedPost.changeset(%QueuedPost{}, @invalid_attrs)
    refute changeset.valid?
  end

  describe "with_empty_content" do
    test "it returns all QueuedPost records without content." do
      %{
        schedule: schedule, collection: collection, channel: channel
      } = insert_channel_resources()

      timeslot = insert(:timeslot, schedule: schedule, collection: collection)
      assert {count, nil} = Extra.Timeslot.build_post_queue(timeslot)

      queued_count = QueuedPost.with_empty_content()
                     |> select([p], count(p.id))
                     |> Repo.one

      assert count == queued_count

      queued_post = QueuedPost.with_empty_content()
                    |> limit(1)
                    |> Repo.one

      post_content = insert(:post_content, collection: collection)
      template = insert(:post_template,
                        post_content: post_content,
                        social_channel: channel)

      QueuedPost
      |> where(id: ^queued_post.id)
      |> update(set: [post_template_id: ^template.id])
      |> Repo.update_all([])

      new_count = QueuedPost.with_empty_content()
                  |> select([p], count(p.id))
                  |> Repo.one

      assert count - 1 == new_count
    end
  end
end
