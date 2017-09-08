defmodule ExtraWeb.SessionController do
  use ExtraWeb, :controller
  alias Extra.User
  alias ExtraWeb.Plug.Auth

  plug :put_layout, {ExtraWeb.LayoutView, :public}

  def new(%{assigns: %{current_user: %User{}}} = conn, _) do
    conn
    |> redirect(to: dashboard_path(conn, :index))
  end

  def new(conn, _params) do
    changeset = User.registration_changeset(%User{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"user" => %{"email" => email, "password" => password}}) do
    case Auth.login_by_email_and_pass(conn, email, password, repo: Repo) do
      {:ok, user} ->
        conn
        |> Guardian.Plug.sign_in(user)
        |> put_flash(:info, "Welcome back!")
        |> redirect(to: dashboard_path(conn, :index))
      {:error, reason, conn} ->
        changeset = User.changeset(%User{}, %{email: email})
        conn
        |> put_flash(:error, reason)
        |> render("new.html", changeset: changeset)
    end
  end

  def delete(conn, _params) do
    conn
    |> Guardian.Plug.sign_out()
    |> put_flash(:info, "You are now signed out of Extra.")
    |> redirect(to: session_path(conn, :new))
  end
end
