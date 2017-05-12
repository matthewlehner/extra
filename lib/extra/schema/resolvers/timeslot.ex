defmodule Extra.Schema.Resolvers.Timeslot do
  @moduledoc """
  Resolver for the Timeslot object
  """
  alias Extra.Repo
  alias Extra.Timeslot

  def create(%{timeslot: timeslot_params}, %{context: %{current_user: user}}) do
    %Timeslot{}
    |> Timeslot.changeset_for_user(timeslot_params, user)
    |> Repo.insert()
  end
end
