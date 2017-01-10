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

      {:error, _changeset} ->
        conn
        |> put_flash(:error, "The account you are trying to add has already been added to Extra.")
        |> redirect(to: social_channel_path(conn, :new))
    end
  end
end
