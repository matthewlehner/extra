defmodule Extra.SocialCollectionControllerTest do
  use Extra.ConnCase
  import Extra.TestHelper

  alias Extra.SocialCollection
  @valid_attrs %{name: "some content"}
  @invalid_attrs %{}

  setup do
    user = Repo.insert!(%Extra.User{})
    conn = build_conn()
           |> sign_in(user)

    {:ok, conn: conn, user: user}
  end

  test "renders form for new resources", %{conn: conn} do
    conn = get conn, social_collection_path(conn, :new)
    assert html_response(conn, 200) =~ "New social collection"
  end

  test "creates resource and redirects when data is valid", %{conn: conn} do
    conn = post conn, social_collection_path(conn, :create), social_collection: @valid_attrs
    new_collection = Repo.get_by!(SocialCollection, @valid_attrs)
    assert new_collection
    assert redirected_to(conn) == social_collection_path(conn, :show, new_collection)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, social_collection_path(conn, :create), social_collection: @invalid_attrs
    assert html_response(conn, 200) =~ "New social collection"
  end

  test "shows chosen resource", %{conn: conn, user: user} do
    social_collection = Repo.insert! %SocialCollection{user_id: user.id}
    conn = get conn, social_collection_path(conn, :show, social_collection)
    assert html_response(conn, 200) =~ "Show social collection"
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    social_collection = Repo.insert! %SocialCollection{}
    assert_error_sent 404, fn ->
      get conn, social_collection_path(conn, :show, social_collection)
    end
  end
end
