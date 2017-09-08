defmodule ExtraWeb.SessionView do
  use ExtraWeb, :view

  # <p class="alert alert-info" role="alert"><%= get_flash(@conn, :info) %></p>
  # <p class="alert alert-danger" role="alert"><%= get_flash(@conn, :error) %></p>

  def render_flash(conn) do
    conn
    |> Phoenix.Controller.get_flash
    |> Enum.map(&render_message/1)
  end

  defp render_message({"error", message}) do
    render_message(message, "alert alert-danger")
  end

  defp render_message({"info", message}) do
    render_message(message, "alert alert-info")
  end

  defp render_message(message, class) do
    content_tag :p, translate_error({message, []}), class: class
  end
end
