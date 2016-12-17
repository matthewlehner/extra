defmodule Extra.TestHelper do
  @default_opts [
    store: :cookie,
    key: "foobar",
    encryption_salt: "encrypted cookie salt",
    signing_salt: "signing salt"
  ]
  @secret String.duplicate("abcdef0123456789", 8)
  @signing_opts Plug.Session.init(Keyword.put(@default_opts, :encrypt, false))

  def conn_with_fetched_session(conn) do
    put_in(conn.secret_key_base, @secret)
    |> Plug.Session.call(@signing_opts)
    |> Plug.Conn.fetch_session
  end

  def sign_in(conn, resource) do
    conn
    |> conn_with_fetched_session
    |> Guardian.Plug.sign_in(resource, :token, perms: %{default: Guardian.Permissions.max})
    |> Guardian.Plug.VerifySession.call(%{})
  end
end

{:ok, _} = Application.ensure_all_started(:ex_machina)

ExUnit.start

Ecto.Adapters.SQL.Sandbox.mode(Extra.Repo, :manual)

