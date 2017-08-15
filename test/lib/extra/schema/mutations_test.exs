defmodule Extra.Schema.MutationsTest do
  use Extra.ModelCase, async: true

  alias Extra.Schema

  @queries_dir "web/static/js/app/queries"

  @update_schedule_mutation File.read!(
    "#{@queries_dir}/update-schedule.gql"
  )

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

      assert {:ok, response} = Absinthe.run @update_schedule_mutation,
                                            Schema,
                                            variables: mutation_variables,
                                            context: context

      assert response == %{data: %{"updateSchedule" => %{
        "autopilot" => false,
        "id" => to_string(schedule.id)
      }}}
    end
  end

  @add_timeslot_mutation File.read!(
    "#{@queries_dir}/add-timeslot-mutation.gql"
  )

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
      assert {:ok, %{data: response}} = Absinthe.run(
                                 @add_timeslot_mutation,
                                 Schema,
                                 variables: mutation_variables,
                                 context: context
                               )

      %{"addTimeslot" => %{"id" => timeslot_id}} = response
      timeslot = Repo.get(Extra.Timeslot, timeslot_id)

      assert response == %{"addTimeslot" => %{
        "recurrence" => "MONDAY",
        "time" => "09:00:00",
        "id" => to_string(timeslot.id),
        "collection" => %{
          "id" => to_string(collection.id),
          "name" => collection.name
        }
      }}

      assert schedule.id == timeslot.schedule_id
      assert collection.id == timeslot.collection_id
      assert :monday == timeslot.recurrence
      assert ~T[09:00:00.000000] == timeslot.time
    end
  end

  @add_post_content_mutation File.read!(
    "#{@queries_dir}/add-post-content-mutation.gql"
  )

  describe "add_content mutation" do
    test "it creates a new timeslot" do
      user = insert :user
      collection = insert :post_collection, user: user
      channels = insert_pair(:social_channel, user: user)
      channel_ids = Enum.map(channels, &(&1.id))
      [channel1 | [channel2]] = channels

      body = "something else!"

      variables = %{
        "input" => %{
          "body" => body,
          "collectionId" => collection.id,
          "channelIds" => channel_ids
        }
      }

      context = %{current_user: user}

      assert {:ok, %{data: response}} = Absinthe.run @add_post_content_mutation,
                                                     Schema,
                                                     variables: variables,
                                                     context: context

      %{"addContent" => %{ "content" => %{"id" => post_id}}} = response
      assert response == %{"addContent" => %{
        "content" => %{
          "id" => post_id,
          "body" => body,
          "channels" => [
            %{"id" => to_string(channel1.id), "name" => channel1.name},
            %{"id" => to_string(channel2.id), "name" => channel2.name},
          ],
          "collection" => %{
            "id" => to_string(collection.id),
            "name" => collection.name
          }
        },
        "contentErrors" => []
      }}
    end
  end

  @update_user_password_mutation File.read!(
    "#{@queries_dir}/update-user-password-mutation.gql"
  )
  describe "UpdatePassword" do
    test "updates user's password" do
      user = insert :user, password_hash: Comeonin.Bcrypt.hashpwsalt("password")
      variables = %{
        "input" => %{
          "current" => "password",
          "new" => "new password!"
        }
      }

      context = %{current_user: user}

      assert {:ok, %{data: response}} =
        @update_user_password_mutation
        |> Absinthe.run(Schema, variables: variables, context: context)

      assert response == %{
        "updatePassword" => %{
          "user" => %{
            "id" => to_string(user.id),
            "email" => user.email
          },
          "userErrors" => []
        }
      }
    end
  end

  @update_user_preferences_mutation File.read!(
    "#{@queries_dir}/update-user-preferences.gql"
  )

  describe "UpdatePreferences" do
    test "updates user's preferences" do
      user = insert :user
      variables = %{
        "input" => %{
          "email" => "mynew@email.com",
          "timezone" => "Canada/Pacific",
        }
      }

      context = %{current_user: user}

      assert {:ok, %{data: response}} =
        @update_user_preferences_mutation
        |> Absinthe.run(Schema, variables: variables, context: context)

      assert response == %{
        "updatePreferences" => %{
          "id" => to_string(user.id),
          "email" => "mynew@email.com",
          "timezone" => "Canada/Pacific"
        }
      }
    end
  end

  @update_post_content_mutation File.read!(
    "#{@queries_dir}/update-post-content-mutation.gql"
  )

  describe "UpdatePostContent" do
    test "updates a post and related templates" do
      %{
        user: user,
        collection: collection,
        channel: channel
      } = insert_channel_resources()

      post = insert :post_content, collection: collection

      variables = %{
        "input" => %{
          "id" => post.id,
          "body" => "hi bud",
          "channelIds" => [channel.id]
        }
      }

      context = %{current_user: user}

      assert {:ok, %{data: response}} =
        @update_post_content_mutation
        |> Absinthe.run(Schema, variables: variables, context: context)

      assert response == %{
        "updateContent" => %{
          "content" => %{
            "id" => to_string(post.id),
            "body" => "hi bud",
            "channels" => [
              %{
                "id" => to_string(channel.id),
                "image" => channel.image,
                "name" => channel.name,
                "provider" => channel.provider
              }
            ]
          },
          "contentErrors" => []
        }
      }
    end
  end

  @archive_post_content_mutation File.read!(
    "#{@queries_dir}/archive-post-content-mutation.gql"
  )

  describe "archivePost" do
    test "archives a post" do
      %{
        user: user,
        collection: collection
      } = insert_channel_resources()
      post = insert :post_content, collection: collection

      variables = %{"id" => post.id}
      context = %{current_user: user}

      assert {:ok, %{data: response}} =
        @archive_post_content_mutation
        |> Absinthe.run(Schema, variables: variables, context: context)

      assert response == %{
        "archivePostContent" => %{
          "id" => to_string(post.id),
          "collection" => %{"id" => to_string(collection.id)}
        }
      }
    end
  end

  @remove_timeslot_mutation File.read!(
    "#{@queries_dir}/remove-timeslot-mutation.gql"
  )

  describe "removeTimeslot mutation" do
    test "removes timeslot" do
      %{
        user: user, collection: collection
      } = insert_channel_resources()
      timeslot = insert(:timeslot, collection: collection)

      variables = %{"id" => timeslot.id}
      context = %{current_user: user}

      assert {:ok, %{data: response}} =
        Absinthe.run @remove_timeslot_mutation,
                     Schema,
                     variables: variables,
                     context: context

      assert response == %{
        "removeTimeslot" => %{
          "id" => to_string(timeslot.id),
        }
      }
      refute Extra.Repo.get(Extra.Timeslot, timeslot.id)
    end
  end
end
