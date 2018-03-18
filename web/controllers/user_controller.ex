# web/controllers/user_controller
defmodule CrossSocialMediasApi.UserController do
  use CrossSocialMediasApi.Web, :controller

  alias CrossSocialMediasApi.{User, Repo}

  defp perform_update(conn, user, params) do
    changeset = User.registration_changeset(user, params)
    case Repo.update(changeset) do
      {:ok, user} ->
        render(conn, "show.json", user: user)
      {:error, _result} ->
        conn |> put_status(:bad_request) |> render("update_error.json")
    end
  end

  def index(conn, _params) do
    users = Repo.all(User)
    render conn, "index.json", users: users
  end

  def me(conn, _params) do
    case Guardian.Plug.current_resource(conn) do
      nil -> conn |> put_status(404) |> render("error.json")
      user -> render(conn, "show.json", user: user)
    end
  end

  def show(conn, %{"id" => id}) do
    case Repo.get(User, id) do
      nil -> conn |> put_status(404) |> render("error.json")
      user -> render(conn, "show.json", user: user)
    end
  end

  def create(conn, params) do
    changeset = User.registration_changeset(%User{}, params)

    case Repo.insert(changeset) do
          {:ok, user} ->
            conn |> put_status(:created) |> render("show.json", user: user)
          {:error, _changeset} ->
            json conn |> put_status(:bad_request), %{errors: ["unable to create user"] }
    end
  end

  def update(conn, %{"id" => id} = params) do
    user = Repo.get(User, id)
    if user do
      perform_update(conn, user, params)
    else
      json conn |> put_status(:not_found),
                   %{errors: ["invalid user"] }
    end
  end
end