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
      user = insert(:user)
      channel = insert(:social_channel, user: user)
      schedule = insert(:schedule, channel: channel)

      context = %{current_user: user}
      mutation_variables = %{
        "channelId" => schedule.social_channel_id,
        "autopilot" => false
      }

      assert {:ok, response} = @update_schedule_mutation
                               |> Absinthe.run(Schema, variables: mutation_variables, context: context)

      assert response == %{data: %{"updateSchedule" => %{
        "autopilot" => false,
        "id" => to_string(schedule.id)
      }}}
    end
  end

  # TODO - figure out a way to load these from the gql files.
  @add_timeslot_mutation """
  mutation AddTimeslot(
    $scheduleId: ID!, $collectionId: ID!, $recurrence: Recurrence!, $time: Time!
  ) {
    addTimeslot(
      timeslot: {
       scheduleId: $scheduleId
       collectionId: $collectionId
       recurrence: $recurrence
       time: $time
      }
    ) {
      id, time, recurrence
    }
  }
  """

  describe "add_timeslot mutation" do
    test "it creates a new timeslot" do
      user = insert(:user)
      channel = insert(:social_channel, user: user)
      schedule = insert(:schedule, channel: channel)
      collection = insert(:post_collection, user: user)

      mutation_variables = %{"scheduleId" => schedule.id,
                             "collectionId" => collection.id,
                             "recurrence" => "MONDAY",
                             "time" => "09:00:00"}

      context = %{current_user: user}
      assert {:ok, response} = Absinthe.run(
                                 @add_timeslot_mutation,
                                 Schema,
                                 variables: mutation_variables,
                                 context: context
                               )

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

  @add_post_content_mutation """
  mutation AddPostContent(
    $body: String!, $collectionId: ID!, $channelIds: [ID]!
  ) {
    addPost(
      body: $body, collectionId: $collectionId, channelIds: $channelIds
    ) {
      body
      collection { id name }
      channels { id name }
    }
  }
  """
  describe "add_post_content mutation" do
    test "it creates a new timeslot" do
      user = insert :user
      collection = insert :post_collection, user: user
      channels = insert_pair(:social_channel, user: user)
      channel_ids = Enum.map(channels, &(&1.id))
      [channel1 | [channel2]] = channels

      body = "something else!"

      variables = %{
        "body" => body,
        "collectionId" => collection.id,
        "channelIds" => channel_ids
      }

      context = %{current_user: user}

      assert {:ok, response} =
        @add_post_content_mutation
        |> Absinthe.run(Schema, variables: variables, context: context)

      assert response == %{data: %{"addPost" => %{
        "body" => body,
        "channels" => [
          %{"id" => to_string(channel1.id), "name" => channel1.name},
          %{"id" => to_string(channel2.id), "name" => channel2.name},
        ],
        "collection" => %{
          "id" => to_string(collection.id),
          "name" => collection.name
        }
      }}}
    end
  end

  @update_user_password_mutation """
  mutation UpdatePassword($current: String!, $new: String!) {
    updatePassword(password: { current: $current, new: $new }) {
      email
    }
  }
  """
  describe "UpdatePassword" do
    test "updates user's password" do
      user = insert :user, password_hash: Comeonin.Bcrypt.hashpwsalt("password")
      variables = %{
        "current" => "password",
        "new" => "new password!",
      }

      context = %{current_user: user}

      assert {:ok, %{data: response}} =
        @update_user_password_mutation
        |> Absinthe.run(Schema, variables: variables, context: context)

      assert %{"updatePassword" => %{"email" => user.email}} == response
    end
  end
end
