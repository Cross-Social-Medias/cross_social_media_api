# web/models.social_media_mapping.ex
defmodule CrossSocialMediasApi.SocialMediaMapping do
  use CrossSocialMediasApi.Web, :model

  schema "social_media_mappings" do
    field :mapping_name, :string
    field :twitter_username, :string
    field :instagram_username, :string
    field :created_by, :integer
    
    timestamps()
  end

  def changeset(model, params \\ :empty) do
    model
      |> cast(params, [:mapping_name, :twitter_username, :instagram_username, :created_by])
      |> validate_required([:mapping_name, :twitter_username, :created_by])
  end
end