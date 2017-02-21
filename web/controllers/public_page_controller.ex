defmodule Extra.PublicPageController do
  use Extra.Web, :controller

  plug :put_layout, {Extra.LayoutView, :marketing}

  def index(conn, _params) do
    render conn, "index.html"
  end
end
