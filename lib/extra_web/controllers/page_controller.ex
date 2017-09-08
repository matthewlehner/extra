defmodule ExtraWeb.PageController do
  use ExtraWeb, :controller

  plug :put_layout, {ExtraWeb.LayoutView, :app}

  def index(conn, _params) do
    render conn, "index.html", layout: {ExtraWeb.LayoutView, "public.html"}
  end

  def styleguide(conn, _) do
    render conn, "styleguide.html"
  end

  def icons(conn, _) do
    render conn, "icons.html"
  end
end
