defmodule Extra.InputHelpers do
  use Phoenix.HTML

  defp input_defaults, do: [class: "form__control", placeholder: " "]
  defp label_defaults, do: [class: "form__control-label"]

  def input(form, field, opts \\ [input: [], label: []]) do
    type = opts[:using] || Phoenix.HTML.Form.input_type(form, field)

    input_opts = Phoenix.HTML.Form.input_validations(form, field)
                 |> Keyword.merge(extend_input_opts(form, field))
                 |> Keyword.merge(input_defaults())
                 |> Keyword.merge(Keyword.get(opts, :input))

    wrapper_opts = [class: "form__control-group #{state_class(form, field)} #{presence_class(form, field)}"]

    content_tag :div, wrapper_opts do
      input = input(type, form, field, input_opts)
      label = label(form, field, humanize(field), label_defaults())
      error = Extra.ErrorHelpers.error_tag(form, field) || ""
      [label, input, error]
    end
  end

  defp state_class(form, field) do
    cond do
      # The form was not yet submitted
      !form.source.action -> ""
      form.errors[field] -> "has-error"
      true -> "has-success"
    end
  end

  defp presence_class(%{source: %{changes: changes}}, _) when changes == %{},  do: nil

  defp presence_class(_, :password), do: nil

  defp presence_class(%{source: %{changes: changes}}, field) do
    case changes[field] do
      nil -> "input-empty dirty"
      "" -> "input-empty dirty"
      _ -> "dirty"
    end
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
end
