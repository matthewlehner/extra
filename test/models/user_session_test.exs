defmodule Extra.UserSessionTest do
  use Extra.ModelCase

  alias Extra.UserSession

  @valid_attrs %{last_activity_at: %{day: 17, hour: 14, min: 0, month: 4, sec: 0, year: 2010}, last_activity_ip: "some content", login_ip: "some content", user_agent: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = UserSession.changeset(%UserSession{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = UserSession.changeset(%UserSession{}, @invalid_attrs)
    refute changeset.valid?
  end
end
