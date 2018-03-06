defmodule CrossSocialMediasApi.Repo.Migrations.AddUserInSocialMediaMapping do
  use Ecto.Migration

  def change do
    alter table(:social_media_mappings) do
      add :user_id, references(:users, on_delete: :nothing)
    end
  end
end
