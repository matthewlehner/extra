defmodule Extra.Recurrence do
  @moduledoc """
  Recurrence holds functions for working with the Recurrence Enum.
  """

  @doc """
  Returns the days of the week that are covered by the recurrence enum.

  ## Examples

  iex> Extra.Recurrence.days_of_week_for(:monday)
  [1]

  iex> Extra.Recurrence.days_of_week_for(:weekdays)
  [1, 2, 3, 4, 5]
  """

  def days_of_week_for(:monday), do: [1]
  def days_of_week_for(:tuesday), do: [2]
  def days_of_week_for(:wednesday), do: [3]
  def days_of_week_for(:thursday), do: [4]
  def days_of_week_for(:friday), do: [5]
  def days_of_week_for(:saturday), do: [6]
  def days_of_week_for(:sunday), do: [7]

  def days_of_week_for(:everyday), do: [1, 2, 3, 4, 5, 6, 7]
  def days_of_week_for(:weekdays), do: [1, 2, 3, 4, 5]
  def days_of_week_for(:weekends), do: [6, 7]

  def cron_weekday(:everyday), do: [:*]
  def cron_weekday(:weekends), do: [{:-, 6, 7}]
  def cron_weekday(:weekdays), do: [{:-, 1, 5}]
  def cron_weekday(day), do: days_of_week_for(day)
end
