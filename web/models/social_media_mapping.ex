# web/models.social_media_mapping.ex
defmodule CrossSocialMediasApi.SocialMediaMapping do
  use CrossSocialMediasApi.Web, :model

  schema "social_media_mappings" do
    field :mapping_name, :string
    field :twitter_username, :string
    field :instagram_username, :string
    field :youtube_channel_id, :string
    field :created_by, :integer

    belongs_to :user, CrossSocialMediasApi.User
    timestamps()
  end

  def changeset(model, params \\ :empty) do
    model
      |> cast(params, [:mapping_name, :twitter_username, :instagram_username, :youtube_channel_id, :created_by, :user_id])
      |> validate_required([:mapping_name, :twitter_username, :created_by, :user_id])
      |> assoc_constraint(:user)
  end
end