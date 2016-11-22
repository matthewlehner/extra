defmodule Extra.RegistrationControllerTest do
  use Extra.ConnCase

  @valid_attrs %{email: "an@email.com", password: "something"}
  @invalid_attrs %{}

  test "renders form for new resources", %{conn: conn} do
    conn = get conn, registration_path(conn, :new)
    assert html_response(conn, 200) =~ "New registration"
  end

  test "creates resource and redirects when data is valid", %{conn: conn} do
    conn = post conn, registration_path(conn, :create), user: @valid_attrs
    assert redirected_to(conn) == dashboard_path(conn, :index)
    assert Repo.get_by(Extra.User, %{email: @valid_attrs.email})
  end

  test "does not create resource and renders errors when data is invalid",
  %{conn: conn} do
    conn = post conn, registration_path(conn, :create), user: @invalid_attrs
    assert html_response(conn, 200) =~ "New registration"
  end
end
