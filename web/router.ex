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
    plug Extra.Auth
  end

  pipeline :require_login do
    plug Guardian.Plug.EnsureAuthenticated
    plug Extra.LoadSidebarEntities, repo: Extra.Repo
  end

  scope "/", Extra do
    pipe_through [:browser]
    get "/", PublicPageController, :index
  end

  scope "/", Extra do
    pipe_through [:browser, :browser_session, :public_layout]

    get "/login", SessionController, :new
    post "/login", SessionController, :create
    delete "/logout", SessionController, :delete
    resources "/registrations", RegistrationController, only: [:new, :create]
  end

  scope "/app", Extra do
    pipe_through [:browser, :browser_session, :require_login]

    # These can be removed at some point, or moved to an ADMIN route with static
    # markup, rather than pulling from current_user associations.
    get "/styleguide", PageController, :styleguide
    get "/icons", PageController, :icons

    get "/", DashboardController, :index
    resources "/channels", SocialChannelController, only: [:new, :show]
    resources "/collections", CollectionController, only: [:new, :create, :show]
    resources "/posts", PostController, only: [:new, :create]
  end

  scope "/admin", Extra do
    pipe_through [:browser]

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
