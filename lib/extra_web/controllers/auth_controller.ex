defmodule ExtraWeb.AuthController do
  @moduledoc """
  Auth controller responsible for handling Ueberauth responses
  """

  use ExtraWeb, :controller
  plug Ueberauth
  alias Extra.PublishingChannels

  def request(conn, _params) do
    conn
    |> redirect(to: session_path(conn, :new))
  end

  def callback(%{assigns: %{ueberauth_failure: _fails}} = conn, _params) do
    conn
    |> put_flash(:error, "Failed to authenticate")
    |> redirect(to: "/")
  end

  def callback(%{assigns: %{ueberauth_auth: auth, current_user: user}} = conn, _params) do
    response = PublishingChannels.persist_ueberauth_response(auth, user)

    case response do
      {:ok, channel} ->
        conn
        |> put_flash(:info, "Successfully authenticated")
        |> redirect(to: app_path(conn, :index, ["channels", to_string(channel.id)]))

      {:error, _changeset} ->
        conn
        |> put_flash(:error, "The account you are trying to add has already been added to Extra.")
        |> redirect(to: app_path(conn, :index, ["new-channel"]))
    end
  end
end
