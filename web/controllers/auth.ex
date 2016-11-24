defmodule Extra.Auth do
  @moduledoc """
  Authentication helper methods and plugs.
  """

  alias Extra.Router.Helpers

  import Plug.Conn
  import Phoenix.Controller
  import Comeonin.Bcrypt, only: [checkpw: 2, dummy_checkpw: 0]

  require Ecto.Query

  def init(opts) do
    Keyword.fetch!(opts, :repo)
  end

  def call(conn, repo) do
    session_id = get_session(conn, :session_id)
    user       = session_id && repo.one(user_query(session_id))

    if user do
      assign(conn, :current_user, user)
    else
      conn
      |> delete_session:session_id)
      |> assign(:current_user, nil)
    end
  end

  def authenticate_user(conn, _opts) do
    if conn.assigns.current_user do
      conn
    else
      conn
      |> delete_session(:session_id)
      |> put_flash(:error, "You must be logged in to access that page")
      |> redirect(to: Helpers.session_path(conn, :new))
      |> halt()
    end
  end

  def login(conn, user) do
    if get_session(conn, :session_id) do
      conn
    else
      session = Extra.UserSession.for_user(conn, user)

      conn
      |> put_session(:session_id, session.id)
      |> configure_session(renew: true)
    end
  end

  def login_by_email_and_pass(conn, email, given_pass, opts) do
    repo = Keyword.fetch!(opts, :repo)
    user = repo.get_by(Extra.User, email: email)

    cond do
      user && checkpw(given_pass, user.password_hash) ->
        {:ok, login(conn, user)}
      user ->
        {:error, :unauthorized, conn}
      true ->
        {:error, :not_found, conn}
    end
  end

  defp user_query(session_id) do
    Ecto.Query.from u in Extra.User,
      join: s in Extra.UserSession, on: s.user_id == u.id,
      where: s.id == ^session_id
  end
end
