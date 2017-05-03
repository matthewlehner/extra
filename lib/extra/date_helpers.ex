defmodule Extra.DateHelpers do
  @moduledoc """
  Functions for working with dates.
  """

  @doc """
  Translates an day number into a string.

  ## Examples

  iex> Extra.DateHelpers.to_day_name(1)
  "Monday"

  iex> Extra.DateHelpers.to_day_name(7)
  "Sunday"

  iex> Extra.DateHelpers.to_day_name(8)
  :error
  """

  @spec to_day_name(non_neg_integer) :: String.t
  def to_day_name(day_number)
  def to_day_name(day_number) when day_number > 7, do: :error

  def to_day_name(day_number) do
    Timex.day_name(day_number)
  end

  @doc """
  Returns the date for the next occurence of a specific day.

  It can accept any argument that `Timex.day_to_num` can parse
  iex> Extra.DateHelpers.next_day(:mon, ~D[2017-05-01])
  ~D[2017-05-08]

  iex> Extra.DateHelpers.next_day("Tue", ~D[2017-05-01])
  ~D[2017-05-02]

  iex> Extra.DateHelpers.next_day("Wednesday", ~D[2017-05-01])
  ~D[2017-05-03]

  Can accept day of the week integers as well
  iex> Extra.DateHelpers.next_day(5, ~D[2017-05-01])
  ~D[2017-05-05]
  """
  @spec next_day(:atom | integer, Date.t) :: Date.t
  @spec next_day(:atom | integer, DateTime.t) :: DateTime.t
  def next_day(day_name, from_date \\ Date.utc_today)
  def next_day(day_name, from_date) when is_binary(day_name) or is_atom(day_name) do
    day_name
    |> Timex.day_to_num()
    |> next_day(from_date)
  end

  def next_day(day, from_date) do
    from_day = Timex.weekday(from_date)

    days_until = case from_day >= day do
      true  -> (day + 7 - from_day)
      false -> (day - from_day)
    end

    Timex.shift(from_date, [days: days_until])
  end
end
