defmodule Extra.Schema.Resolvers.UserResolver do
  @moduledoc """
  Functions for the user type in the GraphQL schema.
  """
  alias Extra.User
  import Ecto.Changeset, only: [traverse_errors: 2]
  import Extra.ErrorHelpers, only: [translate_error: 1]

  def update(params, %{context: %{current_user: user}}) do
    case User.update(user, params) do
      {:ok, next_user} -> {:ok, next_user}
      {:error, changeset} ->
        errors = traverse_errors(changeset, &translate_error/1)
        {:error, errors}
    end
  end

  def update_password(%{password: %{current: current, new: new}},
                      %{context: %{current_user: user}}) do
    User.update_password(user, %{current: current, new: new})
  end
end
