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

  def create(conn, params) do
    changeset = SocialMediaMapping.changeset(%SocialMediaMapping{}, params)

    case Repo.insert(changeset) do
          {:ok, social_media_mapping} ->
            conn |> put_status(:created) |> render "show.json", social_media_mapping: social_media_mapping
          {:error, _changeset} ->
            json conn |> put_status(:bad_request), %{errors: ["unable to create mapping"] }
    end
  end

  def update(conn, %{"id" => id} = social_media_mapping_params) do
    social_media_mapping = Repo.get(SocialMediaMapping, id) 
    changeset = SocialMediaMapping.changeset(social_media_mapping, social_media_mapping_params)
    if social_media_mapping do
      case Repo.update(changeset) do 
        {:ok, social_media_mapping} ->
          render conn, "show.json", social_media_mapping: social_media_mapping
        {:error, _result} ->
          conn |> put_status(:bad_request) |> render("update_error.json")
      end
    else 
      json conn |> put_status(:not_found),
             %{errors: ["invalid mapping"] }
    end
  end
end