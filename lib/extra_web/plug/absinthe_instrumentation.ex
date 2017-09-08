defmodule ExtraWeb.Plug.AbsintheInstrumentation do
  @behaviour Plug
  import Appsignal.Instrumentation.Helpers, only: [instrument: 3]

  def init(opts), do: opts

  def call(conn = %{params: %{"operationName" => operation_name}}, _) do
    Appsignal.Transaction.set_action("Absinthe##{operation_name}")

    instrument("graphql.absinthe", "Accessing GraphQL endpoint.", fn() ->
      conn
    end)
  end

  def call(conn, _), do: conn
end
