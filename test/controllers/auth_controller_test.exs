defmodule Extra.AuthControllerTest do
  use Extra.ConnCase, async: true

  test "redirects identity to login path.", %{conn: conn} do
    conn = get conn, auth_path(conn, :request, "identity")
    assert redirected_to(conn) == "/login"
  end
end
