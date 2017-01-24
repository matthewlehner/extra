defmodule Extra.CollectionController do
  use Extra.Web, :controller

  alias Extra.PostCollection

  def new(conn, _params) do
    changeset = PostCollection.changeset(%PostCollection{})
    cancel_url = referer_or_fallback(conn)
    render(conn, "new.html", changeset: changeset,
                             cancel_url: cancel_url)
  end

  def create(%{assigns: %{current_user: user}} = conn, %{"post_collection" => params}) do
    changeset = user
                |> build_assoc(:post_collections)
                |> PostCollection.changeset(params)

    case Repo.insert(changeset) do
      {:ok, collection} ->
        conn
        |> put_flash(:info, "Collection created successfully.")
        |> redirect(to: collection_path(conn, :show, collection))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset, cancel_url: referer_or_fallback(nil, conn))
    end
  end

  def show(%{assigns: %{current_user: user}} = conn, %{"id" => id}) do
    collection = Repo.get_by!(PostCollection, id: id, user_id: user.id)
                 |> Repo.preload(posts: [templates: :social_channel])
    render(conn, "show.html", collection: collection)
  end

  defp referer_or_fallback(conn) do
    Plug.Conn.get_req_header(conn, "referer")
    |> referer_or_fallback(conn)
  end

  defp referer_or_fallback([url], _) when is_binary(url), do: url
  defp referer_or_fallback(_, conn) do
    dashboard_path(conn, :index)
  end
end
