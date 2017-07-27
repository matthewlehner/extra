defmodule Extra.Schema.ResolverHelpers do
  @moduledoc """
  Functions for helping in resolvers
  """

  def errors_on(changeset) do
    changeset
    |> Ecto.Changeset.traverse_errors(&Extra.ErrorHelpers.translate_error/1)
    |> Enum.flat_map(fn {key, errors} ->
      for msg <- errors, do: %{field: key, message: msg}
    end)
  end
end
