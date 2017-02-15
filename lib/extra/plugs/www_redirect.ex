defmodule Extra.Plugs.WWWRedirect do
  @moduledoc """
  Plug for redirecting bare domain to www.hostname
  """

  import Plug.Conn

  def init(options), do: options

  def call(conn, _options) do
    if bare_domain?(conn.host) do
      conn
      |> Phoenix.Controller.redirect(external: www_url(conn))
      |> halt()
    else
      conn
    end
  end

  defp www_url(conn) do
    "https://www." <> conn.host <> redirect_path(conn)
  end

  defp bare_domain?(host), do: !Regex.match?(~r/\Awww\..*\z/i, host)

  defp redirect_path(%{request_path: "/"}), do: ""
  defp redirect_path(%{request_path: path}), do: path
end
