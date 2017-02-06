defmodule Extra.PostView do
  use Extra.Web, :view

  def templates_for(changeset, channels) do
    changeset
    |> Map.fetch!(:data)
    |> Extra.PostContent.build_potential_templates(channels)
  end

  def channel_label(changeset, channels) do
    id = changeset
         |> input_value(:social_channel_id)

    channels
    |> Enum.find(&(&1.id == id))
    |> Map.fetch!(:name)
  end
end
