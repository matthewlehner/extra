defmodule Extra.Schema.MutationsTest do
  use Extra.ModelCase, asyc: true

  alias Extra.Schema

  @update_schedule_mutation """
    mutation UpdateSchedule($channelId: ID!, $autopilot: Boolean) {
      updateSchedule(channelId: $channelId, schedule: { autopilot: $autopilot })
      { id, autopilot }
    }
  """

  describe "update_schedule mutation" do
    test "it updates a schedule" do
      schedule = insert(:schedule)

      mutation_variables = %{
        "channelId" => schedule.social_channel_id,
        "autopilot" => false
      }

      assert {:ok, response} = @update_schedule_mutation
                               |> Absinthe.run(Schema, variables: mutation_variables)

      assert response == %{data: %{"updateSchedule" => %{
        "autopilot" => false,
        "id" => to_string(schedule.id)
      }}}
    end
  end

  @add_timeslot_mutation """
  mutation AddTimeslot(
    $scheduleId: ID!, $collectionId: ID!, $recurrence: Recurrence!, $time: Time!
  ) {
    addTimeslot(
      scheduleId: $scheduleId, collectionId: $collectionId, timeslot: {
        recurrence: $recurrence, time: $time
      }
    ) {
      id, time, recurrence
    }
  }
  """

  describe "add_timeslot mutation" do
    test "it creates a new timeslot" do
      schedule = insert(:schedule)
      collection = insert(:post_collection)

      mutation_variables = %{"scheduleId" => schedule.id,
                             "collectionId" => collection.id,
                             "recurrence" => "MONDAY",
                             "time" => "09:00:00"}

      assert {:ok, response} = @add_timeslot_mutation
                               |> Absinthe.run(Schema, variables: mutation_variables)

      %{data: %{"addTimeslot" => %{"id" => timeslot_id}}} = response
      timeslot = Repo.get(Extra.Timeslot, timeslot_id)

      assert response == %{data: %{"addTimeslot" => %{
        "recurrence" => "MONDAY", "time" => "09:00:00", "id" => to_string(timeslot.id)
      }}}

      assert schedule.id == timeslot.schedule_id
      assert collection.id == timeslot.collection_id
      assert :monday == timeslot.recurrence
      assert ~T[09:00:00.000000] == timeslot.time
    end
  end
end
