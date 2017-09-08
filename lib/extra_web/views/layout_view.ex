defmodule ExtraWeb.LayoutView do
  use ExtraWeb, :view

  def body_class_name(conn) do
    "#{controller_name(conn)}-#{Phoenix.Controller.action_name(conn)}"
  end

  defp controller_name(conn) do
    conn
    |> Phoenix.Controller.controller_module()
    |> Phoenix.Naming.resource_name("Controller")
  end

  def render_flash(%Plug.Conn{} = conn) do
    content_tag :div, class: "flash_container" do
      [
        flash_element(get_flash(conn, :info), :info),
        flash_element(get_flash(conn, :error), :error)
      ]
    end
  end

  defp flash_element(message, type) when is_binary(message) do
    content_tag :div, message,
      class: "flash_message flash_message__" <> flash_class(type),
      role: "alert"
  end

  defp flash_element(_, _), do: ""

  defp flash_class(type) do
    case type do
      :error -> "error"
      _ -> "info"
    end
  end
end
