defmodule Extra.TimeslotTest do
  use Extra.ModelCase, asyc: true

  alias Extra.Timeslot
  alias Extra.Schedule

  test "changeset with invalid attributes" do
    errors = errors_on(%Timeslot{})
    assert {:time, "can't be blank"} in errors
    assert {:recurrence, "can't be blank"} in errors
    assert {:collection_id, "can't be blank"} in errors
  end

  describe "changeset" do
    test "creates insertable changeset" do
      schedule = insert(:schedule)
      collection = insert(:post_collection)

      params = %{
        time: ~T[09:00:00],
        recurrence: :everyday,
        collection_id: collection.id
      }

      assert {:ok, timeslot} = Schedule
                               |> Repo.get(schedule.id)
                               |> build_assoc(:timeslots)
                               |> Timeslot.changeset(params)
                               |> Repo.insert

      assert timeslot.collection_id == collection.id
      assert timeslot.schedule_id == schedule.id
      assert timeslot.time == params.time
      assert timeslot.recurrence == params.recurrence
    end
  end

  describe "build_post_queue" do
    test "inserts a bunch of stuff into the database" do
      timeslot = :timeslot
                 |> insert()

      assert {7, nil} == Timeslot.build_post_queue(timeslot)
      assert {0, nil} == Timeslot.build_post_queue(timeslot)
    end
  end
end
