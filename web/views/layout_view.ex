defmodule Extra.LayoutView do
  use Extra.Web, :view

  def body_class_name(conn) do
    "#{controller_name(conn)}-#{Phoenix.Controller.action_name(conn)}"
  end

  defp controller_name(conn) do
    Phoenix.Controller.controller_module(conn)
    |> Phoenix.Naming.resource_name("Controller")
  end
end
