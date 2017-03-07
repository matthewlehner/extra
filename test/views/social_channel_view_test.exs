defmodule Extra.SocialChannelViewTest do
  use Extra.ConnCase, async: true

  alias Extra.SocialChannelView

  describe "tab_link" do
    test "renders a tab link" do
      tab_el = "Monday"
               |> SocialChannelView.tab_link
               |> Phoenix.HTML.safe_to_string

      assert tab_el =~ "class=\"tab\""
      assert tab_el =~ "id=\"monday-tab\""
      assert tab_el =~ "aria-controls=\"monday\""
      assert tab_el =~ "aria-selected=\"false\""
      assert tab_el =~ "data-title=\"Monday\""
    end

    test "renders aria-select=\"active\"" do
      tab_el = "Monday"
               |> SocialChannelView.tab_link(true)
               |> Phoenix.HTML.safe_to_string

      assert tab_el =~ "aria-selected=\"true\""
    end
  end
end
