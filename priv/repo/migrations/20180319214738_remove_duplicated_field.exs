defmodule CrossSocialMediasApi.Repo.Migrations.RemoveDuplicatedField do
  use Ecto.Migration

  def change do
    alter table(:social_media_mappings) do
      remove :created_by
    end
  end
end
