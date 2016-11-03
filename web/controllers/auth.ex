defmodule Extra.Auth do
  @moduledoc """
  Authentication helper methods and plugs.
  """

  alias Extra.Router.Helpers

  import Plug.Conn
  import Phoenix.Controller

  require Ecto.Query

  def init(opts) do
    Keyword.fetch!(opts, :repo)
  end

  def call(conn, repo) do
    session_id = get_session(conn, :session_id)
    user       = session_id && repo.one(user_query(session_id))
    assign(conn, :current_user, user)
  end

  def authenticate_user(conn, _opts) do
    if conn.assigns.current_user do
      conn
    else
      conn
      |> put_flash(:error, "You must be logged in to access that page")
      |> redirect(to: Helpers.page_path(conn, :index))
      |> halt()
    end
  end

  def login_from_user(conn, user) do
    if get_session(conn, :session_id) do
      conn
    else
      session = Extra.UserSession.for_user(conn, user)

      conn
      |> put_session(:session_id, session.id)
      |> configure_session(renew: true)
    end
  end

  defp user_query(session_id) do
    Ecto.Query.from u in Extra.User,
      join: s in Extra.UserSession, on: s.user_id == u.id,
      where: s.id == ^session_id
  end
end
