defmodule ExtraWeb.Plug.GraphqlContext do
  @behaviour Plug
  import Plug.Conn

  def init(options), do: options

  def call(conn, _options) do
    case Guardian.Plug.current_resource(conn) do
      nil -> conn
      user -> put_private(conn, :absinthe, %{context: %{current_user: user}})
    end
  end
end
