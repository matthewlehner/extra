defmodule ExtraWeb.Endpoint do
  use Phoenix.Endpoint, otp_app: :extra

  socket "/socket", ExtraWeb.UserSocket

  # Serve at "/" the static files from "priv/static" directory.
  #
  # You should set gzip to true if you are running phoenix.digest
  # when deploying your static files in production.
  plug Plug.Static,
    at: "/", from: :extra, gzip: false,
    only: ~w(css fonts images js favicon.ico robots.txt google382af0016fa8aa6d.html),
    headers: [{"access-control-allow-origin", "*"}]

  # Code reloading can be explicitly enabled under the
  # :code_reloader configuration of your endpoint.
  if code_reloading? do
    socket "/phoenix/live_reload/socket", Phoenix.LiveReloader.Socket
    plug Phoenix.LiveReloader
    plug Phoenix.CodeReloader
  end

  plug Plug.RequestId
  plug Plug.Logger

  if config[:redirect_to_www] do
    plug ExtraWeb.Plug.WWWRedirect
  end

  plug Plug.Parsers,
    parsers: [:urlencoded, :multipart, :json],
    pass: ["*/*"],
    json_decoder: Poison

  plug Plug.MethodOverride
  plug Plug.Head

  # The session will be stored in the cookie and signed,
  # this means its contents can be read but not tampered with.
  # Set :encryption_salt if you would also like to encrypt it.
  plug Plug.Session,
    store: :cookie,
    key: "_extra_key",
    signing_salt: "7AnGC9LB"

  use Appsignal.Phoenix
  plug ExtraWeb.Router
end
