defmodule Extra.CollectionControllerTest do
  use Extra.ConnCase
  import Extra.TestHelper

  alias Extra.PostCollection
  @valid_attrs %{name: "some content"}
  @invalid_attrs %{}

  setup do
    user = Repo.insert!(%Extra.User{})
    conn = build_conn()
           |> sign_in(user)

    {:ok, conn: conn, user: user}
  end

  test "renders form for new resources", %{conn: conn} do
    conn = get conn, collection_path(conn, :new)
    assert html_response(conn, 200) =~ "Create a new collection"
  end

  test "creates resource and redirects when data is valid", %{conn: conn} do
    conn = post conn, collection_path(conn, :create), post_collection: @valid_attrs
    new_collection = Repo.get_by!(PostCollection, @valid_attrs)
    assert new_collection
    assert redirected_to(conn) == collection_path(conn, :show, new_collection)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, collection_path(conn, :create), post_collection: @invalid_attrs
    assert html_response(conn, 200) =~ "Create a new collection"
  end

  test "shows chosen resource", %{conn: conn, user: user} do
    post_collection = Repo.insert! %PostCollection{user_id: user.id, name: "collection name"}
    conn = get conn, collection_path(conn, :show, post_collection)
    assert html_response(conn, 200) =~ post_collection.name
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    post_collection = Repo.insert! %PostCollection{}
    assert_error_sent 404, fn ->
      get conn, collection_path(conn, :show, post_collection)
    end
  end
end
