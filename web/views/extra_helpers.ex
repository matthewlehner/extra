defmodule Extra.ExtraHelpers do
  @moduledoc """
  Global helpers for use in any view or template.
  """

  use Phoenix.HTML
  import Extra.Router.Helpers

  @doc """
  Generates svg tags for icon sprite usage.
  """
  def icon(%Plug.Conn{} = conn, name) do
    template = get_template_name(conn)
               |> String.replace(".html", "")
    content_tag(:svg, class: "icon icon_" <> name) do
      content_tag(:use, "", "xlink:href": "#{static_path(conn, "/images/#{template}.svg")}##{name}")
    end
  end

  def icon(name) do
    content_tag(:svg, class: "icon") do
      content_tag(:use, "", "xlink:href": "##{name}-icon")
    end
  end

  defp get_template_name(conn) do
    {Extra.LayoutView, template} = conn.assigns[:layout]
    template
  end
end
