defmodule Extra.SessionController do
  use Extra.Web, :controller

  alias Extra.UserSession
  import Comeonin.Bcrypt, only: [checkpw: 2, dummy_checkpw: 0]

  def new(conn, _params) do
    render(conn, "new.html")
  end

  def create(conn, %{"session" => %{"email" => email, "password" => password}}) do
    case Extra.Auth.login_by_email_and_pass(conn, email, password, repo: Repo) do
      {:ok, conn} ->
        conn
        |> put_flash(:info, "Welcome back")
        |> redirect(to: dashboard_path(conn, :index))
      {:error, _reason, conn} ->
        conn
        |> put_flash(:error, "We couldn't find your email and passwore combination")
        |> render("new.html")
    end
  end

  def delete(conn, _params) do
    session_id = get_session(conn, :session_id)
    session = Repo.get!(UserSession, session_id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(session)

    conn
    |> put_flash(:info, "Session deleted successfully.")
    |> redirect(to: page_path(conn, :index))
  end
end
