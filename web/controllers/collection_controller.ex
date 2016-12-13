defmodule Extra.CollectionController do
  use Extra.Web, :controller

  alias Extra.SocialCollection

  def new(conn, _params) do
    changeset = SocialCollection.changeset(%SocialCollection{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(%{assigns: %{current_user: user}} = conn, %{"social_collection" => params}) do
    params = Map.put(params, "user_id", user.id)
    changeset = SocialCollection.changeset(%SocialCollection{}, params)

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
    social_collection = Repo.get_by!(SocialCollection, id: id, user_id: user.id)
    render(conn, "show.html", social_collection: social_collection)
  end
end
