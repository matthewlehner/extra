defmodule Extra.PostManager do
  @moduledoc """
  Functions for archiving post content and associated records.
  """

  import Ecto.Query, only: [exclude: 2]
  import Ecto, only: [assoc: 2]
  alias Ecto.Multi
  alias Extra.PostContent
  alias Extra.Repo

  @spec archive(%PostContent{}) ::{:ok, %{
    post_content: %PostContent{}, queued_posts: {integer, nil | [term]}
  }}
  def archive(%PostContent{} = content) do
    Multi.new
    |> Multi.update(:post_content, PostContent.archive_changeset(content))
    |> Multi.update_all(:queued_posts,
                        content |> assoc(:queued_posts) |> exclude(:distinct),
                        set: [post_template_id: nil])
    |> Repo.transaction()
  end

  @spec archive(any) :: {:error, String.t()}
  def archive(_), do: {:error, "No post content struct given."}
end
