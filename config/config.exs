# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :extra,
  ecto_repos: [Extra.Repo]

# Configures the endpoint
config :extra, Extra.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "z+F16wmp3ZMZMi12fVGAzHhaP/4hQQOK9lcri5PbIBmHwxoiapikQbBLuA/pdWMo",
  render_errors: [view: Extra.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Extra.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

config :ueberauth, Ueberauth,
  providers: [
    shopify: {Ueberauth.Strategy.Shopify, []}
  ]

config :ueberauth, Uberauth.Strategy.Shopify.OAuth,
  client_id: "",
  client_secret: ""


# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
