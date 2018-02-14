# web/controllers/user_controller
defmodule CrossSocialMediasApi.UserController do
  use CrossSocialMediasApi.Web, :controller

  def index(conn, _params) do
    users = Repo.users()
    json conn, users
  end

  def show(conn, %{"id" => id}) do
    user = Repo.get_user(String.to_integer(id))

    json conn, user
  end
end