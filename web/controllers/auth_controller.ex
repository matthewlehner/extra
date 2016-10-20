defmodule Extra.AuthController do
  @moduledoc """
  Auth controller responsible for handling Ueberauth responses
  """

  use Extra.Web, :controller
  plug Ueberauth

  alias Ueberauth.Strategy.Helpers

end
