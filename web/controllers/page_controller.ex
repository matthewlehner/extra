defmodule Extra.PageController do
  use Extra.Web, :controller

  def index(conn, _params) do
    render conn, "index.html", layout: {Extra.LayoutView, "public.html"}
  end

  def styleguide(conn, _) do
    render conn, "styleguide.html", layout: {Extra.LayoutView, "app.html"}
  end
end
