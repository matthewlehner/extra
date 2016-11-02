defmodule Extra.AuthController do
  @moduledoc """
  Auth controller responsible for handling Ueberauth responses
  """

  use Extra.Web, :controller

  alias Ueberauth.Strategy.Helpers

  def callback(%{assigns: %{ueberauth_failure: _fails}} = conn, _params) do

    conn
    |> put_flash(:error, "Failed to authenticate")
    |> redirect(to: "/")
  end

  def callback(%{assigns: %{ueberauth_auth: auth}} = conn, params) do
    case Extra.UserFromAuth.find_or_create(auth) do
      {:ok, user} ->
        conn
        |> put_flash(:info, "Successfully authenticated")
        |> Extra.Auth.login_from_user(user)
        |> redirect(to: "/")

      {:error, reason} ->
        conn
        |> put_flash(:error, reason)
        |> redirect(to: "/")
    end
  end
end
