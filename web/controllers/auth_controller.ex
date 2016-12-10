defmodule Extra.AuthController do
  @moduledoc """
  Auth controller responsible for handling Ueberauth responses
  """

  use Extra.Web, :controller
  plug Ueberauth

  def request(conn, _params) do
    conn
    |> redirect(to: session_path(conn, :new))
  end

  def callback(%{assigns: %{ueberauth_failure: _fails}} = conn, _params) do
    conn
    |> put_flash(:error, "Failed to authenticate")
    |> redirect(to: "/")
  end

  def callback(%{assigns: %{ueberauth_auth: auth, current_user: current_user}} = conn, _params) do
    changeset = Extra.SocialChannel.changeset_from_auth(auth, current_user)

    case Repo.insert(changeset) do
      {:ok, channel} ->
        conn
        |> put_flash(:info, "Successfully authenticated")
        |> redirect(to: social_channel_path(conn, :show, channel))

      {:error, reason} ->
        conn
        |> put_flash(:error, reason)
        |> redirect(to: social_channel_path(conn, :index))
    end
  end
end
