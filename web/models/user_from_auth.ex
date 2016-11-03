defmodule Extra.UserFromAuth do
  @moduledoc """
  Retrieves the user information from an auth request
  """

  alias Ueberauth.Auth
  alias Extra.AuthToken
  alias Extra.User
  import Ecto.Query

  def find_or_create(%Auth{provider: :shopify} = auth) do
    query = from u in Extra.User,
      join: t in AuthToken, on: t.user_id == u.id,
      where: t.token == ^auth.credentials.token and
             t.uid == ^auth.uid

    user = Extra.Repo.one(query) || create_user_and_auth_token(auth)

    {:ok, user}
  end

  def find_or_create(_) do
    {:error, "Whatever you're doing hasn't been implemented yet"}
  end

  defp create_user_and_auth_token(auth) do
    # create an auth token, and a user
    params = %{token: auth.credentials.token, uid: auth.uid, provider: auth.provider}

    auth_token_changeset = AuthToken.changeset(%AuthToken{}, params)

    %User{}
    |> User.changeset
    |> Ecto.Changeset.put_assoc(:auth_tokens, [auth_token_changeset])
    |> Extra.Repo.insert
  end
end
