defmodule Extra.Schema.Resolvers.ScheduleResolverTest do
  use Extra.ModelCase, async: true
  alias Extra.Schema.Resolvers.Schedule, as: ScheduleResolver

  setup do
    %{user: user, schedule: schedule} = insert_channel_resources()
    {:ok, schedule: schedule, user: user}
  end

  describe "update/2" do
    test "updates schedule attributes", %{schedule: schedule, user: user} do
      params = %{
        channel_id: schedule.social_channel_id,
        schedule_input: %{
          timezone: "Canada/Pacific"
        }
      }

      context = %{context: %{current_user: user}}

      assert {:ok, schedule} = ScheduleResolver.update(params, context)
      assert schedule.timezone == "Canada/Pacific"
    end
  end
end
