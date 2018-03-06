defmodule CrossSocialMediasApi.Repo.Migrations.AddUserIdInSocialMediaMapping do
  use Ecto.Migration

  def change do
    alter table(:social_media_mappings) do
      add :created_by, :integer
    end
  end
end
