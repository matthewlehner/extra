defmodule PostBot.PageController do
  use PostBot.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
