defmodule Extra.PublicPageController do
  use Extra.Web, :controller

  plug :put_layout, {Extra.LayoutView, :marketing}

  def index(conn, _params) do
    render conn, "index.html", show_login: true
  end

  def alpha_thanks(conn, _params) do
    render conn, "alpha_thanks.html"
  end

  def alpha_confirmed(conn, _params) do
    render conn, "alpha_confirmed.html"
  end

  def seven_tactics(conn, _params) do
    render conn, "seven-tactics.html"
  end
end
