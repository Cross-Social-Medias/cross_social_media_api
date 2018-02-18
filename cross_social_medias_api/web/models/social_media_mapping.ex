# web/models.social_media_mapping.ex
defmodule CrossSocialMediasApi.SocialMediaMapping do
  use CrossSocialMediasApi.Web, :model

  schema "social_media_mappings" do
    field :mapping_name, :string
    field :twitter_username, :string
    field :instagram_username, :string
    
    timestamps()
  end

  def changeset(model, params \\ :empty) do
    model
      |> cast(params, [:mapping_name, :twitter_username, :instagram_username])
      |> validate_required([:mapping_name, :twitter_username])
  end
end