defmodule Extra.Schema.MutationsTest do
  use Extra.ModelCase, asyc: true

  alias Extra.Schema

  @update_schedule_mutation """
    mutation UpdateSchedule($channelId: ID!, $autopilot: Boolean) {
      updateSchedule(
        channelId: $channelId, schedule: { autopilot: $autopilot }
      ) { id, autopilot }
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
    $scheduleId: ID!, $collectionId: ID!, $recurrence: recurrence!, $time: time!
  ) {
    addTimeslot(
      scheduleId: $scheduleId, collectionId: $collectionId,
      recurrence: $recurrence, time: $time
    ) {
      time, recurrence, collectionId, scheduleId
    }
  }
  """

  describe "add_timeslot mutation" do
    test "it creates a new timeslot" do
    end
  end
end
