defmodule Extra.PostController do
  use Extra.Web, :controller

  alias Extra.PostContent

  def new(conn, _params) do
    channels = conn.assigns[:current_user].social_channels

    changeset =
      PostContent.changeset(%PostContent{}, %{})
      |> PostContent.with_channel_templates(channels)

    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"post_content" => post_params}) do
    changeset = PostContent.changeset(%PostContent{}, post_params)

    case Repo.insert(changeset) do
      {:ok, post} ->
        conn
        |> put_flash(:info, "Post created successfully.")
        |> redirect(to: collection_path(conn, :show, post.post_collection_id))
      {:error, changeset} ->
        channels = conn.assigns[:current_user].social_channels

        changeset =
          changeset
          |> PostContent.with_channel_templates(channels)

        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    post = Repo.get!(PostContent, id)
    render(conn, "show.html", post: post)
  end

  def edit(conn, %{"id" => id}) do
    post = Repo.get!(PostContent, id)
    changeset = PostContent.changeset(post)
    render(conn, "edit.html", post: post, changeset: changeset)
  end

  def update(conn, %{"id" => id, "post" => post_params}) do
    post = Repo.get!(PostContent, id)
    changeset = PostContent.changeset(post, post_params)

    case Repo.update(changeset) do
      {:ok, post} ->
        conn
        |> put_flash(:info, "PostContent updated successfully.")
        |> redirect(to: post_path(conn, :show, post))
      {:error, changeset} ->
        render(conn, "edit.html", post: post, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    post = Repo.get!(PostContent, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(post)

    conn
    |> put_flash(:info, "PostContent deleted successfully.")
    |> redirect(to: post_path(conn, :index))
  end
end
