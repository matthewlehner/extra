defmodule Extra.PageControllerTest do
  use Extra.ConnCase, async: true

  test "GET /", %{conn: conn} do
    conn = get conn, "/"
    assert html_response(conn, 200) =~
           "Extra is a social media automation tool that intelligently and automatically reposts content at the perfect moment each and every day."
  end
end
