defmodule Extra.Schema.Resolvers.UserResolver do
  @moduledoc """
  Functions for the user type in the GraphQL schema.
  """

  alias Extra.User

  def update_password(%{current: current, new: new},
                      %{context: %{current_user: user}}) do

    User.update_password(user, %{current: current, new: new})
  end
end
