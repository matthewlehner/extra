defmodule Extra.InputHelpers do
  use Phoenix.HTML

  @input_options [:placeholder, :using, :collection]

  defp input_defaults, do: [class: "form__control"]
  defp label_defaults, do: [class: "form__control-label"]

  def input(form, field, opts \\ [input: [], label: []]) do
    type = extra_input_type(form, field, opts)
    input_opts = input_options_for(form, field, opts)

    wrapper_opts = [class: "form__control-group #{presence_class(form, field)}"]

    input = input(type, form, field, input_opts)
    label = label(form, field, humanize(field), label_defaults())
    error = Extra.ErrorHelpers.error_tag(form, field) || ""

    content_tag :div, wrapper_opts do
      [label, input, error]
    end
  end

  defp presence_class(%{source: %{changes: changes}}, _) when changes == %{}, do: nil
  defp presence_class(_, :password), do: nil

  defp presence_class(%{source: %{changes: changes}}, field) do
    if changes[field] do
      "dirty"
    end
  end

  defp input(:select, form, field, opts) do
    {options, opts} = Keyword.pop(opts, :collection, [])
    Phoenix.HTML.Form.select(form, field, options, opts)
  end

  defp input(:collection_check_boxes, form, field, opts) do
    {options, opts} = Keyword.pop(opts, :collection, [])

    Enum.map(options, fn({label, value}) ->
      opts = opts
             |> Keyword.put_new(:id, input_id(form, field) <> "_#{value}")
             |> Keyword.put_new(:name, input_name(form, field) <> "[#{value}]")
      content_tag :label do
         [input(:checkbox, form, field, Keyword.merge(opts, value: value)),
          label]
      end
    end)
  end

  defp input(type, form, field, opts) do
    apply(Phoenix.HTML.Form, type, [form, field, opts])
  end

  defp extend_input_opts(form, field) do
    case form.source.validations[field] do
      {:format, regex} -> [pattern: Regex.source(regex)]
      _ -> []
    end
  end

  defp extra_input_type(form, field, opts) do
    cond do
      Keyword.has_key?(opts, :using) -> opts[:using]
      Keyword.has_key?(opts, :collection) -> :select
      true -> Phoenix.HTML.Form.input_type(form, field)
    end
  end

  defp input_options_for(form, field, opts) do
    input_validations(form, field)
    |> Keyword.merge(extend_input_opts(form, field))
    |> Keyword.merge(input_defaults())
    |> Keyword.merge(Keyword.take(opts, @input_options))
  end
end
