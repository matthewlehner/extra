defmodule Extra.Schema.Resolvers.TimeslotTest do
  use Extra.ModelCase, async: true
  alias Extra.Timeslot
  alias Extra.QueuedPost
  alias Extra.Schema.Resolvers.Timeslot, as: TimeslotResolver

  describe "create/2" do
    test "creates new timeslot" do
      %{
        user: user, schedule: schedule, collection: collection
      } = insert_channel_resources()

      params = %{
        time: ~T[09:00:00],
        recurrence: :monday,
        collection_id: collection.id,
        schedule_id: schedule.id
      }

      assert {:ok, %Timeslot{} = timeslot} =
        TimeslotResolver.create(%{timeslot: params},
                                %{context: %{current_user: user}})

      assert %QueuedPost{} = queued_post = Extra.Repo.one(QueuedPost)
      assert {:ok, scheduler} = Extra.SchedulerRegistry.find_job(Extra.SchedulerRegistry, timeslot)
      assert timeslot == Extra.TimeslotJob.timeslot(scheduler)
      assert queued_post.id
    end
  end

  describe "archive/2" do
    test "removes timeslot" do
      %{
        user: user, collection: collection
      } = insert_channel_resources()
      timeslot = insert(:timeslot, collection: collection)

      variables = %{id: timeslot.id}
      context = %{context: %{current_user: user}}

      assert {:ok, timeslot} = TimeslotResolver.remove(variables, context)
      assert :error = Extra.SchedulerRegistry.find_job(Extra.SchedulerRegistry, timeslot)
    end

    test "returns error if no timeslot" do
      user = insert(:user)

      assert {:error, "Timeslot 7 not found"} = TimeslotResolver.remove(
        %{id: 7},
        %{context: %{current_user: user}}
      )
    end
  end
end
