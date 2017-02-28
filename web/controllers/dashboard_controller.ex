defmodule Extra.DashboardController do
  @moduledoc """
  Dashboard controller is responsible for the user's signed in page.
  """

  use Extra.Web, :controller

  def index(conn, _params) do
    conn
    |> put_flash(:info, "This is some info")
    |> put_flash(:error, "This is a really, really long error message. Stupidly long, really.")
    |> render("index.html")
  end
end
