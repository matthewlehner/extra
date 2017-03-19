defmodule Extra.ScheduleTest do
  use Extra.ModelCase, async: true

  alias Extra.Schedule

  test "changeset with valid attributes" do
    changeset = Schedule.changeset(%Schedule{}, params_for(:schedule))
    assert changeset.valid?
  end
end
