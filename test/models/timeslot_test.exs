defmodule Extra.TimeslotTest do
  use Extra.ModelCase, asyc: true

  alias Extra.Timeslot

  test "changeset with valid attributes" do
    changeset = Timeslot.changeset(%Timeslot{}, params_for(:timeslot))
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Timeslot.changeset(%Timeslot{}, %{})
    refute changeset.valid?
  end
end
