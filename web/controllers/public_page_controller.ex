defmodule Extra.PublicPageController do
  use Extra.Web, :controller

  plug :put_layout, {Extra.LayoutView, :marketing}

  def index(conn, _params) do
    render conn, "index.html"
  end

  def alpha_thanks(conn, _params) do
    render conn, "alpha_thanks.html"
  end

  def alpha_confirmed(conn, _params) do
    render conn, "alpha_confirmed.html"
  end
end
