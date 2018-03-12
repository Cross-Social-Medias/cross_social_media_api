defmodule CrossSocialMediasApi.Repo.Migrations.AddYoutubeFieldSocialMediaMapping do
  use Ecto.Migration

  def change do
    alter table(:social_media_mappings) do
      add :youtube_channel_id, :string
    end
  end
end
