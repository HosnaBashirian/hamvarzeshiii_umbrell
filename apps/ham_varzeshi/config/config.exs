# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :ham_varzeshi,
  ecto_repos: [HamVarzeshi.Repo]

# Configures the endpoint
config :ham_varzeshi, HamVarzeshiWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "ej26qNAC/t+gmX+1kaZKUCrEKvyx9gQhigUbl0+huNVercvtSpVLh0txeXgFMKbj",
  render_errors: [view: HamVarzeshiWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: HamVarzeshi.PubSub,
  live_view: [signing_salt: "ExG82aLV"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id, :http_method, :http_path, :user]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"

config :arc,
  storage: Arc.Storage.Local
