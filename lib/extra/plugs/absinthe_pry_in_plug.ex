defmodule Extra.AbsinthePryInPlug do
  @behaviour Plug

  def init(opts), do: opts

  def call(conn) do # = %{params: %{"operationName" => operation_name}}, _) do
    # PryIn.CustomTrace.start(group: "Absinthe", key: operation_name)
    #
    # Plug.Conn.register_before_send(conn, fn conn ->
    #   PryIn.CustomTrace.finish()
      conn
    # end)
  end
  def call(conn, _), do: conn
end
