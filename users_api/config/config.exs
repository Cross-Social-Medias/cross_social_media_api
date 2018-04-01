# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :users_api,
  ecto_repos: [UsersApi.Repo]

# Configures the endpoint
config :users_api, UsersApi.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "pbWYMFmGevrlSevly9RGcNa7zPGOy6HRdCsE8op7WYaK22V4VX+aB39wNz6pmgHC",
  render_errors: [view: UsersApi.ErrorView, accepts: ~w(html json)],
  pubsub: [name: UsersApi.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
