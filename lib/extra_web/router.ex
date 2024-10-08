defmodule ExtraWeb.Router do
  use ExtraWeb, :router
  require Ueberauth

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :public_layout do
    plug :put_layout, {ExtraWeb.LayoutView, :public}
  end

  pipeline :browser_session do
    plug Guardian.Plug.VerifySession
    plug Guardian.Plug.LoadResource
    plug ExtraWeb.Plug.Auth
  end

  pipeline :require_login do
    plug Guardian.Plug.EnsureAuthenticated, handler: ExtraWeb.GuardianErrorHandler
  end

  pipeline :api do
    plug ExtraWeb.Plug.AbsintheInstrumentation
    plug :fetch_session
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug Guardian.Plug.VerifySession
    plug Guardian.Plug.LoadResource
    plug Guardian.Plug.EnsureAuthenticated
    plug ExtraWeb.Plug.GraphqlContext
  end

  pipeline :graphiql do
    plug :fetch_session
    plug :put_secure_browser_headers
    plug Guardian.Plug.VerifySession
    plug Guardian.Plug.LoadResource
    plug Guardian.Plug.EnsureAuthenticated
    plug ExtraWeb.Plug.GraphqlContext
  end

  scope "/", ExtraWeb do
    pipe_through [:browser]
    get "/", PublicPageController, :index
    get "/alpha-list/thanks", PublicPageController, :alpha_thanks
    get "/alpha-list/confirmed", PublicPageController, :alpha_confirmed
    get "/seven-tactics", PublicPageController, :seven_tactics
  end

  scope "/", ExtraWeb do
    pipe_through [:browser, :browser_session, :public_layout]

    get "/login", SessionController, :new
    post "/login", SessionController, :create
    delete "/logout", SessionController, :delete
    resources "/registrations", RegistrationController, only: [:new, :create]
  end

  scope "/app", ExtraWeb do
    pipe_through [:browser, :browser_session, :require_login]
    get "/*app_params", AppController, :index

    # These can be removed at some point, or moved to an ADMIN route with static
    # markup, rather than pulling from current_user associations.
    get "/styleguide", PageController, :styleguide
    get "/icons", PageController, :icons

    get "/", DashboardController, :index
  end

  # GraphQL Endpoints
  scope "/" do
    pipe_through :api
    forward "/graphql", Absinthe.Plug, schema: Extra.Schema
  end

  scope "/admin" do
    pipe_through [:graphiql]
    forward "/graphiql", Absinthe.Plug.GraphiQL, schema: Extra.Schema
  end

  scope "/auth", ExtraWeb do
    pipe_through [:browser, :browser_session, :require_login]

    get "/:provider", AuthController, :request
    get "/:provider/callback", AuthController, :callback
    post "/:provider/callback", AuthController, :callback
  end
end
