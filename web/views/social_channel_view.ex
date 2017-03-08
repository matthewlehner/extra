defmodule Extra.SocialChannelView do
  use Extra.Web, :view

  def tab_link(title, active \\ false) do
    link title, to: "#",
                class: "tab",
                id: String.downcase(title) <> "-tab",
                aria: [controls: String.downcase(title), selected: active],
                data: [title: title]
  end

  def channel_json(channel) do
    %{
      name: channel.name,
      image: channel.image,
      provider: channel.provider
    }
  end
end
