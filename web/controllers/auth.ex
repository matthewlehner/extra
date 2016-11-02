defmodule Extra.Auth do
  import Plug.Conn
  require Ecto.Query

  def init(opts) do
    Keyword.fetch!(opts, :repo)
  end

  def call(conn, repo) do
    session_id = get_session(conn, :session_id)
    user       = session_id && repo.one(user_query(session_id))
    assign(conn, :current_user, user)
  end

  def login_from_user(conn, user) do
    session = Extra.UserSession.for_user(conn, user)

    conn
    |> put_session(:session_id, session.id)
    |> configure_session(renew: true)
  end

  defp user_query(session_id) do
    Ecto.Query.from u in Extra.User,
      join: s in Extra.UserSession, on: s.user_id == u.id,
      where: s.id == ^session_id
  end
end
