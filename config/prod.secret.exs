use Mix.Config

# In this file, we keep production configuration that
# you'll likely want to automate and keep away from
# your version control system.
#
# You should document the content of this
# file or create a script for recreating it, since it's
# kept out of version control and might be hard to recover
# or recreate for your teammates (or yourself later on).
config :cross_social_medias_api, CrossSocialMediasApi.Endpoint,
  secret_key_base: "JCaVu1x628WLL6AXAVhbIIT/UWsmpK4GbGwnyfEOYzR5RqU3cuNwxFOPyhb48ZwS"

# Configure your database
config :cross_social_medias_api, CrossSocialMediasApi.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "postgres",
  password: "postgres",
  database: "cross_social_medias_api_prod",
  pool_size: 15
