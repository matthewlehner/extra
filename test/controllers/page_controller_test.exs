defmodule Extra.PageControllerTest do
  use Extra.ConnCase

  test "GET /", %{conn: conn} do
    conn = get conn, "/"
    assert html_response(conn, 200) =~ "Extra automates social media marketing"
  end
end
