defmodule CrossSocialMediasApi.Repo.Migrations.RenameUserColumn do
  use Ecto.Migration

  def change do
  	rename table(:users), :stooge, to: :username
  end
end
