defmodule Extra.Schema.Helpers do
  @moduledoc """
  Helpers for working with Ecto and Absinthe.
  """
  alias Extra.Repo

  def by_id(model, ids) do
    import Ecto.Query
    model
    |> where([m], m.id in ^ids)
    |> Repo.all
    |> Map.new(&{&1.id, &1})
  end
end
