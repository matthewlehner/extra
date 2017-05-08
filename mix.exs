defmodule Extra.Mixfile do
  use Mix.Project

  def project do
    [app: :extra,
     version: "0.0.1",
     elixir: "~> 1.2",
     elixirc_paths: elixirc_paths(Mix.env),
     compilers: [:phoenix, :gettext] ++ Mix.compilers,
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     aliases: aliases(),
     deps: deps(),
     dialyzer: [plt_add_deps: :transitive]]
  end

  # Configuration for the OTP application.
  #
  # Type `mix help compile.app` for more information.
  def application do
    [mod: {Extra, []},
     extra_applications: [:logger]]
  end

  # Specifies which paths to compile per environment.
  defp elixirc_paths(:test), do: ["lib", "web", "test/support"]
  defp elixirc_paths(_),     do: ["lib", "web"]

  # Specifies your project dependencies.
  #
  # Type `mix help deps` for examples and options.
  defp deps do
    [{:phoenix, "~> 1.2.1"},
     {:phoenix_pubsub, "~> 1.0"},
     {:phoenix_ecto, "~> 3.0"},
     {:postgrex, ">= 0.0.0"},
     {:phoenix_html, "~> 2.6"},
     {:phoenix_live_reload, "~> 1.0", only: :dev},
     {:gettext, "~> 0.11"},
     {:cowboy, "~> 1.0"},
     {:guardian, "~> 0.14.0"},
     {:comeonin, "~> 3.0"},
     {:ueberauth_shopify, "~> 0.1.2"},
     {:ueberauth_twitter, github: "ueberauth/ueberauth_twitter"},
     # {:oauth, github: "tim/erlang-oauth"},
     {:ueberauth_facebook, "~> 0.6"},
     {:ueberauth_identity, "~> 0.2.0"},
     {:ecto_enum, "~> 1.0.0"},
     {:timex, "~> 3.0"},

     {:absinthe, "~> 1.3-beta"},
     {:absinthe_plug, "~> 1.3.0-rc.1"},
     {:absinthe_ecto, "~> 0.1.0"},
     {:poison, "~> 2.1"},

     {:ex_machina, "~> 2.0", only: :test},
     {:mix_test_watch, "~> 0.2", only: :dev},
     {:dialyxir, "~> 0.4", only: [:dev]},
     {:credo, "~> 0.4", only: [:dev, :test]}]
  end

  # Aliases are shortcuts or tasks specific to the current project.
  # For example, to create, migrate and run the seeds file at once:
  #
  #     $ mix ecto.setup
  #
  # See the documentation for `Mix` for more info on aliases.
  defp aliases do
    ["ecto.setup": ["ecto.create", "ecto.migrate", "run priv/repo/seeds.exs"],
     "ecto.reset": ["ecto.drop", "ecto.setup"],
     "test": ["ecto.create --quiet", "ecto.migrate", "test"]]
  end
end
