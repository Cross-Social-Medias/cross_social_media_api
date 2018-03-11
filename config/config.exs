# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :cross_social_medias_api,
  ecto_repos: [CrossSocialMediasApi.Repo]

# Configures the endpoint
config :cross_social_medias_api, CrossSocialMediasApi.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "HnTLRUvktGwIwAkFULeeA4k85oUHdIbIx+ZQrSIZxl0tKNJmJHoWJWClK0s/srsA",
  render_errors: [view: CrossSocialMediasApi.ErrorView, accepts: ~w(html json)],
  pubsub: [name: CrossSocialMediasApi.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

config :cors_plug,
  origin: ["http://localhost:3000"],
  max_age: 86400,
  methods: ["GET", "POST"]

# Guardian
config :guardian, Guardian,
  allowed_algos: ["HS512"], # optional
  verify_module: Guardian.JWT,  # optional
  issuer: "CrossSocialMediasApi",
  ttl: { 30, :days },
  allowed_drift: 2000,
  verify_issuer: true, # optional
  secret_key: "LaLvZ5B+M7RooHZLSRQIrZ6EIJ5y7zfqGqwT7Qm8c5JBGbEwk8+UooWNbEVBRSSe", # Insert previously generated secret key!
  serializer: CrossSocialMediasApi.GuardianSerializer

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
