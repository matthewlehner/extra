  defmodule Extra.Schema.Resolvers.PostContent do
    @moduledoc """
    Resolver for PostContent Schema
    """

    import Ecto.Query, only: [where: 2]
    alias Extra.Repo
    alias Extra.PostContent
    alias Extra.PostCollection

    def create(
      %{body: body, collection_id: collection_id, channel_ids: channel_ids},
      %{context: %{current_user: %{id: user_id}}}
    ) do

      templates = Enum.map(channel_ids, &(%{"social_channel_id" => &1}))

      PostCollection
      |> where(user_id: ^user_id)
      |> Repo.get!(collection_id)
      |> Ecto.build_assoc(:posts)
      |> PostContent.changeset(%{body: body, templates: templates})
      |> Repo.insert()
    end

    def create(_, _), do: {:error, "Not Authorized"}
  end
