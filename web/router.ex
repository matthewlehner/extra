defmodule Extra.Router do
  use Extra.Web, :router
  require Ueberauth

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :public_layout do
    plug :put_layout, {Extra.LayoutView, :public}
  end

  pipeline :browser_session do
    plug Guardian.Plug.VerifySession
    plug Guardian.Plug.LoadResource
  end

  pipeline :require_login do
    plug Guardian.Plug.EnsureAuthenticated
    plug Extra.Auth
  end

  scope "/", Extra do
    pipe_through [:browser, :browser_session, :public_layout]

    get "/", PageController, :index
    get "/styleguide", PageController, :styleguide

    get "/login", SessionController, :new
    post "/login", SessionController, :create
    delete "/logout", SessionController, :delete
    resources "/registrations", RegistrationController, only: [:new, :create]
  end

  scope "/app", Extra do
    pipe_through [:browser, :browser_session, :require_login]

    get "/", DashboardController, :index
  end

  scope "/auth", Extra do
    pipe_through [:browser]

    get "/:provider", AuthController, :request
    get "/:provider/callback", AuthController, :callback
    post "/:provider/callback", AuthController, :callback
    delete "/logout", AuthController, :delete
  end

  scope "/.well-known/acme-challenge", Extra do
    get "/:id", LetsEncrypt, :verify
  end
end
