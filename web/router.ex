defmodule Extra.Router do
  use Extra.Web, :router
  require Ueberauth

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug Extra.Auth, repo: Extra.Repo
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", Extra do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
  end

  scope "/app", Extra do
    pipe_through [:browser, :authenticate_user]

    get "/", DashboardController, :index
  end

  scope "/auth", Extra do
    pipe_through [:browser, Ueberauth]

    get "/:provider", AuthController, :request
    get "/:provider/callback", AuthController, :callback
    post "/:provider/callback", AuthController, :callback
    delete "/logout", AuthController, :delete
  end

  # Other scopes may use custom stacks.
  # scope "/api", Extra do
  #   pipe_through :api
  # end
end
