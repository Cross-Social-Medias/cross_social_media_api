defmodule CrossSocialMediasApi.Router do
  use CrossSocialMediasApi.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :authenticated do
    plug Guardian.Plug.EnsureAuthenticated
  end

  scope "/", CrossSocialMediasApi do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
  end

  scope "/api/v1", CrossSocialMediasApi do
      pipe_through :api
      post "/sign_up", RegistrationController, :sign_up
      post "/sign_in", SessionController, :sign_in
      
      pipe_through :authenticated
      resources "/users", UserController
      resources "/social_media_mappings", SocialMediaMappingController
  end

  # Other scopes may use custom stacks.
  # scope "/api", CrossSocialMediasApi do
  #   pipe_through :api
  # end
end
