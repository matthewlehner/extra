defmodule Extra.TimeslotTest do
  use Extra.ModelCase, async: true

  alias Extra.Timeslot

  test "changeset with invalid attributes" do
    errors = errors_on(%Timeslot{})
    assert {:time, "can't be blank"} in errors
    assert {:recurrence, "can't be blank"} in errors
    assert {:collection_id, "can't be blank"} in errors
    assert {:schedule_id, "can't be blank"} in errors
  end

  describe "changeset_for_user" do
    test "creates insertable changeset" do
      %{
        user: user, schedule: schedule, collection: collection
      } = insert_channel_resources()

      params = %{
        time: ~T[09:00:00],
        recurrence: :everyday,
        collection_id: collection.id,
        schedule_id: schedule.id
      }

      assert {:ok, timeslot} = %Timeslot{}
                               |> Timeslot.changeset_for_user(params, user)
                               |> Repo.insert

      assert timeslot.collection_id == collection.id
      assert timeslot.schedule_id == schedule.id
      assert timeslot.time == params.time
      assert timeslot.recurrence == params.recurrence
    end

    test "validates user owns related entities" do
      user = insert(:user)
      schedule = insert(:schedule)
      collection = insert(:post_collection)

      params = %{
        time: ~T[09:00:00],
        recurrence: :everyday,
        collection_id: collection.id,
        schedule_id: schedule.id
      }

      assert {:error, changeset} = %Timeslot{}
                               |> Timeslot.changeset_for_user(params, user)
                               |> Repo.insert

      errors = errors_on(changeset)
      assert {:schedule_id, "not found"} in errors
      assert {:collection_id, "not found"} in errors
    end
  end

  describe "build_post_queue" do
    test "inserts a bunch of stuff into the database" do
      timeslot = insert(:timeslot)

      assert {7, nil} == Timeslot.build_post_queue(timeslot)
      assert {0, nil} == Timeslot.build_post_queue(timeslot)
    end
  end

  import Crontab.CronExpression
  describe ".to_cron_expression" do
    test "works for :everyday" do
      timeslot = build(:timeslot, time: ~T[09:00:00], recurrence: :everyday)
      assert Timeslot.to_cron_expression(timeslot) == ~e[0 9 * * *]
    end

    test "works for :weekends" do
      timeslot = build(:timeslot, time: ~T[09:00:00], recurrence: :weekends)
      assert Timeslot.to_cron_expression(timeslot) == ~e[0 9 * * 6-7 *]
    end

    test "works for :weekdays" do
      timeslot = build(:timeslot, time: ~T[09:00:00], recurrence: :weekdays)
      assert Timeslot.to_cron_expression(timeslot) == ~e[0 9 * * 1-5 *]
    end

    test "works for :individual days" do
      timeslot = build(:timeslot, time: ~T[09:00:00], recurrence: :monday)
      assert Timeslot.to_cron_expression(timeslot) == ~e[0 9 * * 1 *]

      timeslot = build(:timeslot, time: ~T[09:00:00], recurrence: :tuesday)
      assert Timeslot.to_cron_expression(timeslot) == ~e[0 9 * * 2 *]

      timeslot = build(:timeslot, time: ~T[09:00:00], recurrence: :friday)
      assert Timeslot.to_cron_expression(timeslot) == ~e[0 9 * * 5 *]

      timeslot = build(:timeslot, time: ~T[09:00:00], recurrence: :saturday)
      assert Timeslot.to_cron_expression(timeslot) == ~e[0 9 * * 6 *]

      timeslot = build(:timeslot, time: ~T[09:00:00], recurrence: :sunday)
      assert Timeslot.to_cron_expression(timeslot) == ~e[0 9 * * 7 *]
    end
  end
end
