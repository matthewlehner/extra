defmodule Extra.SessionController do
  use Extra.Web, :controller

  alias Extra.UserSession

  plug :authenticate_user, only: :delete

  # def new(conn, _params) do
  #   changeset = UserSession.changeset(%UserSession{})
  #   render(conn, "new.html", changeset: changeset)
  # end

  # def create(conn, %{"session" => session_params}) do
  #   changeset = UserSession.changeset(%UserSession{}, session_params)
  #
  #   case Repo.insert(changeset) do
  #     {:ok, _session} ->
  #       conn
  #       |> put_flash(:info, "Session created successfully.")
  #       |> redirect(to: session_path(conn, :index))
  #     {:error, changeset} ->
  #       render(conn, "new.html", changeset: changeset)
  #   end
  # end

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
