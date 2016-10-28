defmodule Extra.AuthController do
  @moduledoc """
  Auth controller responsible for handling Ueberauth responses
  """

  use Extra.Web, :controller

  # alias Ueberauth.Strategy.Helpers

  # def callback(%{assigns: %{ueberauth_failure: _fails}} = conn, _params) do
  #   conn
  #   |> put_flash(:error, "Failed to authenticate")
  #   |> redirect(to: "/")
  # end
  #
  require IEx
  # def callback(%{assigns: %{ueberauth_auth: auth}} = conn, params) do
  def callback(conn, params) do
    IEx.pry
    conn
  end
end
