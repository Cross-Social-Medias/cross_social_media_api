# web/controllers/user_controller
defmodule CrossSocialMediasApi.UserController do
  use CrossSocialMediasApi.Web, :controller

  def index(conn, _params) do
    users = Repo.all(CrossSocialMediasApi.User)
    json conn, users
  end

  def show(conn, %{"id" => id}) do
    user = Repo.get(CrossSocialMediasApi.User, String.to_integer(id))

    json conn, user
  end
end