defmodule Extra.LayoutViewTest do
  use Extra.ConnCase, async: true

  alias Extra.LayoutView

  describe "flash rendering" do
    setup do
      {:ok, conn: build_conn()}
    end

    test "it does nothing without a flash assigned", %{conn: conn} do
      assert LayoutView.render_flash(conn) == nil
    end

    test "it renders an info flash message" do
    test "it renders an error flash message" do
    end
  end
end
