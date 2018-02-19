# web/controllers/social_media_mapping_controller
defmodule CrossSocialMediasApi.SocialMediaMappingController do
  use CrossSocialMediasApi.Web, :controller

  alias CrossSocialMediasApi.{SocialMediaMapping, Repo}

  def index(conn, _params) do
    social_media_mappings = Repo.all(SocialMediaMapping)
    render conn, "index.json", social_media_mappings: social_media_mappings
  end

  def show(conn, %{"id" => id}) do
    case Repo.get(SocialMediaMapping, id) do
      nil -> conn |> put_status(404) |> render("error.json")
      social_media_mapping -> render conn, "show.json", social_media_mapping: social_media_mapping
    end
  end
end