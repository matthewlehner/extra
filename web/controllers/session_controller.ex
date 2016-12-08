defmodule Extra.SessionController do
  use Extra.Web, :controller
  plug :put_layout, {Extra.LayoutView, :public}

  def new(conn, _params) do
    render(conn, "new.html")
  end

  def create(conn, %{"session" => %{"email" => email, "password" => password}}) do
    case Extra.Auth.login_by_email_and_pass(conn, email, password, repo: Repo) do
      {:ok, user} ->
        conn
        |> Guardian.Plug.sign_in(user)
        |> put_flash(:info, "Welcome back")
        |> redirect(to: dashboard_path(conn, :index))
      {:error, reason, conn} ->
        conn
        |> put_flash(:error, reason)
        |> render("new.html")
    end
  end

  def delete(conn, _params) do
    conn
    |> Guardian.Plug.sign_out()
    |> put_flash(:info, "Session deleted successfully.")
    |> redirect(to: page_path(conn, :index))
  end
end
