defmodule CrossSocialMediasApi.Repo.Migrations.CreateSocialMediaMapping do
  use Ecto.Migration

  def change do
  	create table(:social_media_mappings) do
      add :mapping_name, :string
      add :twitter_username, :string
      add :instagram_username, :string

      timestamps()
    end
  end
end
