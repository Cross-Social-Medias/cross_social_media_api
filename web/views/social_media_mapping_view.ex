defmodule CrossSocialMediasApi.SocialMediaMappingView do
  use CrossSocialMediasApi.Web, :view

  def render("index.json", %{social_media_mappings: social_media_mappings}) do
    %{mappings: render_many(social_media_mappings, CrossSocialMediasApi.SocialMediaMappingView, "social_media_mapping.json")}
  end

  def render("social_media_mapping.json", %{social_media_mapping: social_media_mapping}) do
    %{ mapping_name: social_media_mapping.mapping_name,
       twitter_username: social_media_mapping.twitter_username,
       instagram_username: social_media_mapping.instagram_username,
       youtube_channel_id: social_media_mapping.youtube_channel_id,
       user_id: social_media_mapping.user_id
    }
  end

  def render("show.json", %{social_media_mapping: social_media_mapping}) do
    %{data: render_one(social_media_mapping, CrossSocialMediasApi.SocialMediaMappingView, "social_media_mapping.json")}
  end

  def render("error.json", _assigns) do
    %{error: "mapping not found."}
  end

  def render("update_error.json", _assigns) do
    %{errors: ["unable to update mapping"]}
  end
end