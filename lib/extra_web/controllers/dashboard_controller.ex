defmodule ExtraWeb.DashboardController do
  @moduledoc """
  Dashboard controller is responsible for the user's signed in page.
  """

  use ExtraWeb, :controller

  def index(conn, _params) do
    conn
    |> render("index.html")
  end
end
