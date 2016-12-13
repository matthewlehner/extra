defmodule Extra.CollectionController do
  use Extra.Web, :controller

  alias Extra.PostCollection

  def new(conn, _params) do
    changeset = PostCollection.changeset(%PostCollection{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(%{assigns: %{current_user: user}} = conn, %{"post_collection" => params}) do
    params = Map.put(params, "user_id", user.id)
    changeset = PostCollection.changeset(%PostCollection{}, params)

    case Repo.insert(changeset) do
      {:ok, collection} ->
        conn
        |> put_flash(:info, "Social collection created successfully.")
        |> redirect(to: collection_path(conn, :show, collection))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(%{assigns: %{current_user: user}} = conn, %{"id" => id}) do
    post_collection = Repo.get_by!(PostCollection, id: id, user_id: user.id)
    render(conn, "show.html", post_collection: post_collection)
  end
end
