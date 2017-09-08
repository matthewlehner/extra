defmodule Extra.GuardianErrorHandler do
  @moduledoc """
  Handler functions for Guardian errors.
  """

  import Phoenix.Controller, only: [redirect: 2]
  import ExtraWeb.Router.Helpers, only: [session_path: 2]

  def unauthenticated(conn, _params) do
    redirect(conn, to: session_path(conn, :new))
  end
end
