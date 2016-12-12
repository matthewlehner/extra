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
    plug Extra.LoadSidebarEntities, repo: Extra.Repo
  end

  scope "/", Extra do
    pipe_through [:browser, :browser_session, :public_layout]

    get "/", PageController, :index
    get "/login", SessionController, :new
    post "/login", SessionController, :create
    delete "/logout", SessionController, :delete
    resources "/registrations", RegistrationController, only: [:new, :create]
  end

  scope "/app", Extra do
    pipe_through [:browser, :browser_session, :require_login]

    get "/", DashboardController, :index
    resources "/channels", SocialChannelController, only: [:new, :show]
  end

  scope "/admin", Extra do
    pipe_through [:browser]

    get "/styleguide", PageController, :styleguide
    get "/icons", PageController, :icons
  end

  scope "/auth", Extra do
    pipe_through [:browser, :browser_session, :require_login]

    get "/:provider", AuthController, :request
    get "/:provider/callback", AuthController, :callback
    post "/:provider/callback", AuthController, :callback
  end

  scope "/.well-known/acme-challenge", Extra do
    get "/:id", LetsEncrypt, :verify
  end
end
