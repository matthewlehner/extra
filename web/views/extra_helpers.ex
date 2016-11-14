defmodule Extra.ExtraHelpers do
  @moduledoc """
  Global helpers for use in any view or template.
  """

  use Phoenix.HTML

  @doc """
  Generates svg tags for icon sprite usage.
  """
  def icon(name) do
    content_tag(:svg, class: "icon") do
      content_tag(:use, "", "xlink:href": "##{name}-icon")
    end
  end
end
