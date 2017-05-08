defmodule Extra.QueuedPostTest do
  use Extra.ModelCase

  alias Extra.QueuedPost

  @valid_attrs %{scheduled_for:
    Timex.to_datetime(%{
      day: 17, hour: 14, min: 0, month: 4, sec: 0, year: 2010
    })
  }

  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = QueuedPost.changeset(%QueuedPost{}, @valid_attrs)
    assert changeset.errors == []
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = QueuedPost.changeset(%QueuedPost{}, @invalid_attrs)
    refute changeset.valid?
  end
end
