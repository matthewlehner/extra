defmodule EasyInput.Input do
  alias Phoenix.HTML.Form

  def render(:select, form, field, opts) do
    {options, opts} = Keyword.pop(opts, :collection, [])

    Phoenix.HTML.Tag.content_tag :div, class: "select" do
      Form.select(form, field, options, opts)
    end
  end

  def render(:collection_check_boxes, form, field, opts) do
    {options, opts} = Keyword.pop(opts, :collection, [])

    Enum.map(options, fn({label, value}) ->
      opts =
        opts
        |> Keyword.put_new(:id, Form.input_id(form, field) <> " #{value}")
        |> Keyword.put_new(:name, Form.input_name(form, field) <> "[#{value}]")
        |> Keyword.merge([value: value])

      Phoenix.HTML.Tag.content_tag :label do
        [
          render(:checkbox, form, field, opts),
          label
        ]
      end
    end)
  end

  def render(type, form, field, opts) do
    apply(Phoenix.HTML.Form, type, [form, field, opts])
  end
end
