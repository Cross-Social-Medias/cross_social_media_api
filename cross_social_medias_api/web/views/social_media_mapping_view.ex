defmodule CrossSocialMediasApi.SocialMediaMappingView do
  use CrossSocialMediasApi.Web, :view

  def render("index.json", %{social_media_mappings: social_media_mappings}) do
    %{data: render_many(social_media_mappings, CrossSocialMediasApi.SocialMediaMappingView, "social_media_mapping.json")}
  end

  def render("social_media_mapping.json", %{social_media_mapping: social_media_mapping}) do
    %{name: social_media_mapping.name, email: social_media_mapping.email, stooge: social_media_mapping.stooge}
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