# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :post_bot,
  ecto_repos: [PostBot.Repo]

# Configures the endpoint
config :post_bot, PostBot.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "z+F16wmp3ZMZMi12fVGAzHhaP/4hQQOK9lcri5PbIBmHwxoiapikQbBLuA/pdWMo",
  render_errors: [view: PostBot.ErrorView, accepts: ~w(html json)],
  pubsub: [name: PostBot.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
