defmodule PostManager do
  @moduledoc """
  Functions for archiving post content and associated records.
  """

  import Ecto.Query, only: [from: 2]
  alias Ecto.Multi
  alias Extra.PostContent
  alias Extra.Repo

  @spec archive(%PostContent{}) :: Ecto.Multi.t
  def archive(%PostContent{} = content) do
    Multi.new
    |> Multi.update(:post_content, PostContent.archive_changeset(content))
    |> Multi.update_all(:queued_posts,
                        assoc_queued_posts(content),
                        set: [post_template_id: nil])
    |> Repo.transaction()
  end

  @spec archive(any) :: {:error, String.t()}
  def archive(_), do: {:error, "No post content struct given."}

  def assoc_queued_posts(content) do
    from q in Extra.QueuedPost,
      join: p in Extra.PostTemplate,
      on: p.post_content_id == ^content.id,
      where: q.post_template_id == p.id
  end
end
