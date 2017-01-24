defmodule Extra.PageControllerTest do
  use Extra.ConnCase, async: true

  test "GET /", %{conn: conn} do
    conn = get conn, "/"
    assert html_response(conn, 200) =~ "Extra automates social media marketing"
  end
end
