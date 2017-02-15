defmodule Extra.Plugs.WWWRedirectTest do
  use Extra.ConnCase, async: true

  alias Extra.Plugs.WWWRedirect

  test "does nothing to www domains" do
    conn = build_conn()
    new_conn = WWWRedirect.call(conn, %{})

    assert conn == new_conn
  end

  test "bare domain is redirected" do
    hostname = "example.com"
    conn = build_conn()
           |> Map.put(:host, hostname)
           |> WWWRedirect.call(%{})

    assert redirected_to(conn) == "https://www." <> hostname
  end

  test "bare domain with path is redirected" do
    hostname = "example.com"
    path = "/app"
    conn = :get
           |> build_conn(path)
           |> Map.put(:host, hostname)
           |> WWWRedirect.call(%{})

    assert redirected_to(conn) == "https://www." <> hostname <> path
  end
end
