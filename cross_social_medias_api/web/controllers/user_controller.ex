# web/controllers/user_controller
defmodule CrossSocialMediasApi.UserController do
  use CrossSocialMediasApi.Web, :controller

  def index(conn, _params) do
    users = Repo.users()
    json conn, users
  end

end