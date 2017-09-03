defmodule Extra.AuthorizationTest do
  use Extra.ModelCase, async: true
  alias Extra.Authorization


  describe ".changeset/2" do
    test "with valid attributes" do
      changeset =
        %Authorization{}
        |> Authorization.changeset(params_for(:authorization))

      assert changeset.valid?
    end

    test "with invalid attributes" do
      errors = errors_on(%Authorization{})
      assert {:token, "can't be blank"} in errors
      assert {:secret, "can't be blank"} in errors
    end
  end



    end
  end
end
