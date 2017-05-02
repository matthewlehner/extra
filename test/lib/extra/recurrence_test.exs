defmodule Extra.RecurrenceTest do
  use ExUnit.Case, async: true
  doctest Extra.Recurrence

  alias Extra.Recurrence

  test "returns correct list of days" do
    assert Recurrence.days_of_week_for(:monday) == [1]
    assert Recurrence.days_of_week_for(:tuesday) == [2]
    assert Recurrence.days_of_week_for(:wednesday) == [3]
    assert Recurrence.days_of_week_for(:thursday) == [4]
    assert Recurrence.days_of_week_for(:friday) == [5]
    assert Recurrence.days_of_week_for(:saturday) == [6]
    assert Recurrence.days_of_week_for(:sunday) == [7]

    assert Recurrence.days_of_week_for(:everyday) == [1, 2, 3, 4, 5, 6, 7]
    assert Recurrence.days_of_week_for(:weekdays) == [1, 2, 3, 4, 5]
    assert Recurrence.days_of_week_for(:weekends) == [6, 7]
  end
end
