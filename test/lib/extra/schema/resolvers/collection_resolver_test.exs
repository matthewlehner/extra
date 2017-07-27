defmodule Extra.Schema.CollectionResolverTest do
  use Extra.ModelCase, async: true

  alias Extra.PostCollection
  alias Extra.Schema.CollectionResolver

  setup do
    user = insert(:user)
    {:ok, user: user}
  end

  describe "create/2" do
    test "inserts a new collection", %{user: user} do
      variables = %{input: %{name: "collection name"}}
      context = %{context: %{current_user: user}}

      assert {
        :ok,
        %{
          collection: collection = %PostCollection{},
          collection_errors: []
        }
      } = CollectionResolver.create(variables, context)

      assert collection.user_id == user.id
      assert collection.name == "collection name"
    end

    test "returns errors with invalid params", %{user: user} do
      variables = %{input: %{}}
      context = %{context: %{current_user: user}}

      assert {:ok, response} = CollectionResolver.create(variables, context)
      refute Map.has_key?(response, :collection)
      assert %{collection_errors: errors} = response
      assert errors == [%{field: :name, message: "can't be blank"}]
    end
  end
end
