defmodule Extra.DateHelpers do
  @moduledoc """
  Functions for working with dates.
  """

  alias Calendar.DefaultTranslations

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

  @spec to_day_name(non_neg_integer, atom) :: String.t
  def to_day_name(day_number, lang \\ :en)
  def to_day_name(day_number, _) when day_number > 7, do: :error
  def to_day_name(day_number, lang) do
    Enum.fetch!(weekday_names(lang), day_number - 1)
  end

  defp weekday_names(lang) do
    {:ok, data} = DefaultTranslations.weekday_names(lang)
    data
  end
end
