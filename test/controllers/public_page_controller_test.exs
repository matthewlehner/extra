defmodule Extra.PublicPageControllerTest do
  use Extra.ConnCase, async: true

  test "GET :index", %{conn: conn} do
    conn = get conn, public_page_path(conn, :index)
    assert html_response(conn, 200) =~
           "Extra is a social media automation tool that intelligently and automatically reposts your content at the perfect moment each and every day."
  end
end
