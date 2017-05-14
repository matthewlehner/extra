defmodule Extra.Schema.Resolvers.Timeslot do
  @moduledoc """
  Resolver for the Timeslot object
  """
  alias Extra.Repo
  alias Extra.Timeslot

  def create(%{timeslot: timeslot_params}, %{context: %{current_user: user}}) do
    response = %Timeslot{}
               |> Timeslot.changeset_for_user(timeslot_params, user)
               |> Repo.insert()

    case response do
      {:ok, timeslot} -> Timeslot.build_post_queue(timeslot)
    end

    response
  end
end
