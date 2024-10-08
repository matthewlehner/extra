defmodule ExtraWeb.RegistrationControllerTest do
  use ExtraWeb.ConnCase, async: true

  @valid_attrs %{
    email: "hi@there.com", password: "cool password", full_name: "Henry Ford"
  }
  @invalid_attrs %{}

  test "renders form for new resources", %{conn: conn} do
    conn = get conn, registration_path(conn, :new)
    assert html_response(conn, 200) =~ "Register"
  end

  test "creates resource and redirects when data is valid", %{conn: conn} do
    conn = post conn, registration_path(conn, :create), user: @valid_attrs
    assert redirected_to(conn) == dashboard_path(conn, :index)
    assert Repo.get_by(Extra.User, %{email: @valid_attrs.email})
  end

  test "does not create resource and renders errors when data is invalid",
  %{conn: conn} do
    conn = post conn, registration_path(conn, :create), user: @invalid_attrs
    assert html_response(conn, 200) =~ "Register"
  end
end
