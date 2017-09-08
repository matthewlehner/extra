defmodule ExtraWeb.ExtraHelpers do
  @moduledoc """
  Global helpers for use in any view or template.
  """

  use Phoenix.HTML
  import ExtraWeb.Router.Helpers

  @doc """
  Generates svg tags for icon sprite usage.
  """
  def icon(%Plug.Conn{} = conn, name) do
    template = conn
               |> get_template_name()
               |> String.replace(".html", "")
    content_tag(:svg, class: "icon icon_" <> name) do
      content_tag(:use, "", "xlink:href": "#{static_path(conn, "/images/#{template}.svg")}##{name}-icon")
    end
  end

  def icon(name) do
    content_tag(:svg, class: "icon") do
      content_tag(:use, "", "xlink:href": "##{name}-icon")
    end
  end

  defp get_template_name(conn) do
    {ExtraWeb.LayoutView, template} = conn.assigns[:layout]
    template
  end
end
