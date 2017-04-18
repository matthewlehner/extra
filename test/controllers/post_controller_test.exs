defmodule Extra.PostControllerTest do
  use Extra.ConnCase, async: true
  import Extra.TestHelper
  import Extra.Factory

  alias Extra.PostContent

  setup do
    user = insert(:user)
    conn = build_conn()
           |> sign_in(user)

    {:ok, conn: conn, user: user}
  end

  # test "renders form for new resources", %{conn: conn} do
  #   conn = get conn, post_path(conn, :new)
  #   assert html_response(conn, 200) =~ "Create new post"
  # end
  #
  # test "creates resource and redirects when data is valid", %{conn: conn} do
  #   params = Map.take(params_with_assocs(:post_content), [:body, :post_collection_id])
  #
  #   conn = post conn, post_path(conn, :create), post_content: params
  #   assert redirected_to(conn) == collection_path(conn, :show, params.post_collection_id)
  #   assert Repo.get_by(PostContent, params)
  # end
  #
  # test "does not create resource and renders errors when data is invalid", %{conn: conn} do
  #   conn = post conn, post_path(conn, :create), post_content: %{}
  #   assert html_response(conn, 200) =~ "Create new post"
  # end

  # test "shows chosen resource", %{conn: conn} do
  #   post = Repo.insert! %PostContent{}
  #   conn = get conn, post_path(conn, :show, post)
  #   assert html_response(conn, 200) =~ "Show post"
  # end
  #
  # test "renders page not found when id is nonexistent", %{conn: conn} do
  #   assert_error_sent 404, fn ->
  #     get conn, post_path(conn, :show, -1)
  #   end
  # end
  #
  # test "renders form for editing chosen resource", %{conn: conn} do
  #   post = Repo.insert! %PostContent{}
  #   conn = get conn, post_path(conn, :edit, post)
  #   assert html_response(conn, 200) =~ "Edit post"
  # end
  #
  # test "updates chosen resource and redirects when data is valid", %{conn: conn} do
  #   post = Repo.insert! %PostContent{}
  #   conn = put conn, post_path(conn, :update, post), post: @valid_attrs
  #   assert redirected_to(conn) == post_path(conn, :show, post)
  #   assert Repo.get_by(PostContent, @valid_attrs)
  # end
  #
  # test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
  #   post = Repo.insert! %PostContent{}
  #   conn = put conn, post_path(conn, :update, post), post: @invalid_attrs
  #   assert html_response(conn, 200) =~ "Edit post"
  # end
  #
  # test "deletes chosen resource", %{conn: conn} do
  #   post = Repo.insert! %PostContent{}
  #   conn = delete conn, post_path(conn, :delete, post)
  #   assert redirected_to(conn) == post_path(conn, :index)
  #   refute Repo.get(PostContent, post.id)
  # end
end
