defmodule EasyInput.Label do
  alias Phoenix.HTML.{Form, Tag}

  def render(form, field, opts) do
    {text, opts} = Keyword.pop(opts, :label)

    if text do
      Form.label(form, field, Form.humanize(text), opts)
    else
      Form.label(form, field, opts)
    end
  end

  def render(field, opts) do
    {text, opts} = Keyword.pop(opts, :label, field)
    Tag.content_tag(:label, Form.humanize(text), opts)
  end
end
