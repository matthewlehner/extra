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
config :extra, ExtraWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "z+F16wmp3ZMZMi12fVGAzHhaP/4hQQOK9lcri5PbIBmHwxoiapikQbBLuA/pdWMo",
  render_errors: [view: ExtraWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Extra.PubSub,
           adapter: Phoenix.PubSub.PG2],
  instrumenters: [Appsignal.Phoenix.Instrumenter]

config :phoenix, :template_engines,
  eex: Appsignal.Phoenix.Template.EExEngine,
  exs: Appsignal.Phoenix.Template.ExsEngine

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

config :guardian, Guardian,
  issuer: "Extra",
  ttl: {30, :days},
  secret_key: System.get_env("GUARDIAN_KEY"),
  serializer: Extra.GuardianSerializer

config :ueberauth, Ueberauth, providers: [
  twitter: {Ueberauth.Strategy.Twitter, []},
  identity: {Ueberauth.Strategy.Identity, [
    callback_methods: ["POST"],
    uid_field: :email,
    nickname_field: :email,
  ]}
]

config :ueberauth, Ueberauth.Strategy.Twitter.OAuth,
  consumer_key: System.get_env("TWITTER_CONSUMER_KEY"),
  consumer_secret: System.get_env("TWITTER_CONSUMER_SECRET")

config :extwitter, :oauth,
  consumer_key: System.get_env("TWITTER_CONSUMER_KEY"),
  consumer_secret: System.get_env("TWITTER_CONSUMER_SECRET")

config :extra, Extra.Repo,
  loggers: [Appsignal.Ecto, Ecto.LogEntry]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
