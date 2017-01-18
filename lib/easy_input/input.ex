defmodule EasyInput.Input do
  alias Phoenix.HTML.{Form, Tag}

  def render(:select, form, field, opts) do
    {options, opts} = Keyword.pop(opts, :collection, [])

    Tag.content_tag :div, class: "select" do
      Form.select(form, field, options, opts)
    end
  end

  def render(:collection_check_boxes, form, field, opts) do
    {options, opts} = Keyword.pop(opts, :collection, [])

    checkboxes = checkbox_collection(form, field, options, opts)

    Phoenix.HTML.Tag.content_tag(:div, checkboxes, class: "form__collection-wrapper")
  end

  def render(type, form, field, opts) do
    apply(Phoenix.HTML.Form, type, [form, field, opts])
  end

  defp checkbox_collection(form, field, options, opts) do
    Enum.map options, fn
      {label, value} ->
        opts =
          opts
          |> Keyword.put_new(:id, Form.input_id(form, field) <> "_#{value}")
          |> Keyword.put_new(:name, Form.input_name(form, field) <> "[#{value}]")
          |> Keyword.merge([value: value])

        Tag.content_tag :label do
          [ render(:checkbox, form, field, opts),
            Tag.content_tag(:span, nil, class: "form__indicator form__indicator_checkbox"),
            label ]
        end
    end
  end

end
