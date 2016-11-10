defmodule Extra.LayoutView do
  use Extra.Web, :view

  def icon(name) do
    content_tag(:svg, class: "icon") do
      content_tag(:use, "", "xlink:href": "##{name}-icon")
    end
  end
end
