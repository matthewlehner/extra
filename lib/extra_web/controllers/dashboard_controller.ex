defmodule Extra.DashboardController do
  @moduledoc """
  Dashboard controller is responsible for the user's signed in page.
  """

  use Extra.Web, :controller

  def index(conn, _params) do
    conn
    |> render("index.html")
  end
end
