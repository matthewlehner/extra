defmodule Extra.Auth do
  @moduledoc """
  Authentication helper methods and plugs.
  """

  import Plug.Conn
  import Comeonin.Bcrypt, only: [checkpw: 2, dummy_checkpw: 0]

  require Ecto.Query

  def init(_) do
  end

  def call(conn, _) do
    user = Guardian.Plug.current_resource(conn)
    if user do
      assign(conn, :current_user, user)
    end
  end

  def login_by_email_and_pass(conn, email, given_pass, opts) do
    repo = Keyword.fetch!(opts, :repo)
    user = repo.get_by(Extra.User, email: email)

    cond do
      user && checkpw(given_pass, user.password_hash) ->
        {:ok, user}
      user ->
        dummy_checkpw()
        {:error, "bad password", conn}
      true ->
        {:error, "user not found", conn}
    end
  end

  # defp user_query(session_id) do
  #   Ecto.Query.from u in Extra.User,
  #     join: s in Extra.UserSession, on: s.user_id == u.id,
  #     where: s.id == ^session_id
  # end
end
