defmodule Extra.ScheduleTest do
  use Extra.ModelCase, async: true

  alias Extra.Schedule

  test "changeset with valid attributes" do
    changeset = Schedule.changeset(%Schedule{}, params_for(:schedule))
    assert changeset.valid?
  end

  test "validates timezone" do
    assert {:timezone, "is invalid"} in errors_on(%Schedule{}, %{timezone: "HI"})
  end
end
