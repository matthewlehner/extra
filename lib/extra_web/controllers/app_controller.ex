defmodule Extra.AppController do
  use Extra.Web, :controller

  def index(conn, _) do
    render(conn)
  end
end
