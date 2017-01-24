defmodule Extra.SocialChannelControllerTest do
  use Extra.ConnCase, async: true
  import Extra.TestHelper

  alias Extra.SocialChannel

  setup do
    conn = build_conn()
    user = Repo.insert!(%Extra.User{})

    {:ok, conn: conn, user: user}
  end

  test "renders form for new resources", %{conn: conn, user: user} do
    conn = sign_in(conn, user)
    conn = get conn, social_channel_path(conn, :new)
    assert html_response(conn, 200) =~ "Add a new channel"
  end

  test "shows chosen resource", %{conn: conn, user: user} do
    social_channel = Repo.insert! %SocialChannel{
      name: "great channel", provider: "twitter", user_id: user.id
    }
    conn = sign_in(conn, user)
    conn = get conn, social_channel_path(conn, :show, social_channel)
    assert html_response(conn, 200) =~ social_channel.name
  end

  test "renders page not found when id is nonexistent", %{conn: conn, user: user} do
    conn = sign_in(conn, user)
    assert_error_sent 404, fn ->
      get conn, social_channel_path(conn, :show, -1)
    end
  end

  # test "updates chosen resource and redirects when data is valid", %{conn: conn} do
  #   social_channel = Repo.insert! %SocialChannel{}
  #   conn = put conn, social_channel_path(conn, :update, social_channel), social_channel: @valid_attrs
  #   assert redirected_to(conn) == social_channel_path(conn, :show, social_channel)
  #   assert Repo.get_by(SocialChannel, @valid_attrs)
  # end
  #
  # test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
  #   social_channel = Repo.insert! %SocialChannel{}
  #   conn = put conn, social_channel_path(conn, :update, social_channel), social_channel: @invalid_attrs
  #   assert html_response(conn, 200) =~ "Edit social channel"
  # end
  #
  # test "deletes chosen resource", %{conn: conn} do
  #   social_channel = Repo.insert! %SocialChannel{}
  #   conn = delete conn, social_channel_path(conn, :delete, social_channel)
  #   assert redirected_to(conn) == social_channel_path(conn, :index)
  #   refute Repo.get(SocialChannel, social_channel.id)
  # end
end
