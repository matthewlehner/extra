defmodule PostBot.AuthController do
  @moduledoc """
  Auth controller responsible for handling Ueberauth responses
  """

  use PostBot.Web, :controller
  plug Ueberauth

  alias Ueberauth.Strategy.Helpers

end
