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
    conn
  end
end
