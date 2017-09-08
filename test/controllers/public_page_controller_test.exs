defmodule ExtraWeb.PublicPageControllerTest do
  use ExtraWeb.ConnCase, async: true

  test "GET :index", %{conn: conn} do
    conn = get conn, public_page_path(conn, :index)
    assert html_response(conn, 200) =~
           "Extra is a social media automation tool that intelligently and automatically reposts your content at the perfect moment each and every day."
  end

  test "GET :alpha_thanks", %{conn: conn} do
    conn = get conn, public_page_path(conn, :alpha_thanks)
    assert html_response(conn, 200) =~ "confirmation link"
  end

  test "GET :alpha_confirmed", %{conn: conn} do
    conn = get conn, public_page_path(conn, :alpha_confirmed)
    assert html_response(conn, 200) =~ "Subscription Confirmed"
  end
end
