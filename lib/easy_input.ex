defmodule EasyInput do
  use Phoenix.HTML

  @input_defaults [class: "form__control"]
  @label_defaults [class: "form__control-label"]
  @wrapper_defaults [class: "form__control-group"]

  @input_options [:placeholder, :using, :collection]
  @label_options [:label]

  def association(form, field, opts \\ []) do
    field_type =
      case infer_field_type(form, field, opts) do
        :check_boxes -> :collection_check_boxes
        type -> type
      end

    label_options = options_for(:label, form, field, opts)
    input_options = options_for(:input, form, field, opts)
    wrapper_options = options_for(:wrapper, form, field, opts)

    label = EasyInput.Label.render(field, label_options)
    input = EasyInput.Input.render(field_type, form, field, input_options)
    error = Extra.ErrorHelpers.error_tag(form, field) || ""

    content_tag :div, wrapper_options do
      [label, input, error]
    end
  end

  def input(form, field, opts \\ []) do
    field_type = infer_field_type(form, field, opts)

    label_options = options_for(:label, form, field, opts)
    input_options = options_for(:input, form, field, opts)
    wrapper_options = options_for(:wrapper, form, field, opts)

    label = EasyInput.Label.render(form, field, label_options)
    input = EasyInput.Input.render(field_type, form, field, input_options)
    error = Extra.ErrorHelpers.error_tag(form, field) || ""

    content_tag :div, wrapper_options do
      [label, input, error]
    end
  end

  defp extend_input_opts(form, field) do
    case form.source.validations[field] do
      {:format, regex} -> [pattern: Regex.source(regex)]
      _ -> []
    end
  end

  def options_for(type, form, field, opts \\ [])

  def options_for(:input, form, field, opts) do
    input_validations(form, field)
    |> Keyword.merge(extend_input_opts(form, field))
    |> Keyword.merge(@input_defaults)
    |> Keyword.merge(Keyword.take(opts, @input_options))
  end

  def options_for(:label, _form, _field, opts) do
    @label_defaults
    |> Keyword.merge(Keyword.take(opts, @label_options))
  end

  def options_for(:wrapper, form, field, _opts) do
    @wrapper_defaults
    |> Keyword.update!(:class, fn(class_list) -> wrapper_classes(class_list, form, field) end)
  end

  defp infer_field_type(form, field, opts) do
    cond do
      Keyword.has_key?(opts, :using) -> opts[:using]
      Keyword.has_key?(opts, :collection) -> :select
      true -> input_type(form, field)
    end
  end

  defp wrapper_classes(class_list, form, field) do
    presence_class = presence_class(form, field)
    if presence_class do
      class_list <> " " <> presence_class
    else
      class_list
    end
  end

  defp presence_class(%{source: %{changes: changes}}, _) when changes == %{}, do: nil
  defp presence_class(_, :password), do: nil

  defp presence_class(%{source: %{changes: changes}}, field) do
    if changes[field] do
      "dirty"
    end
  end
end
