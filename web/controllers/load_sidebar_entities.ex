defmodule Extra.LoadSidebarEntities do
  import Plug.Conn

  require Logger

  def init(opts) do
    Keyword.fetch!(opts, :repo)
  end

  def call(%{assigns: %{current_user: user}} = conn, repo) do
    user = user
           |> repo.preload([:social_channels])

    assign(conn, :current_user, user)
  end
end
