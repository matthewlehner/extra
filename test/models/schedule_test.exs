defmodule Extra.ScheduleTest do
  use Extra.ModelCase

  alias Extra.Schedule

  @valid_attrs %{autopilot: true}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Schedule.changeset(%Schedule{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Schedule.changeset(%Schedule{}, @invalid_attrs)
    refute changeset.valid?
  end
end
