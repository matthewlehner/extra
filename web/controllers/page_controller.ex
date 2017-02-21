defmodule Extra.PageController do
  use Extra.Web, :controller

  plug :put_layout, {Extra.LayoutView, :app}

  def index(conn, _params) do
    render conn, "index.html", layout: {Extra.LayoutView, "public.html"}
  end

  def styleguide(conn, _) do
    render conn, "styleguide.html"
  end

  def icons(conn, _) do
    render conn, "icons.html"
  end
end
