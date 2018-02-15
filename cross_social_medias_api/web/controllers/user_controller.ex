# web/controllers/user_controller
defmodule CrossSocialMediasApi.UserController do
  use CrossSocialMediasApi.Web, :controller

  defp conn_with_status(conn, nil) do
    conn
      |> put_status(:not_found)
  end

  defp conn_with_status(conn, _) do
    conn
      |> put_status(:ok)
  end

  defp perform_update(conn, user, params) do
    changeset = CrossSocialMediasApi.User.changeset(user, params)
    case Repo.update(changeset) do
      {:ok, user} ->
        json conn |> put_status(:ok), user
      {:error, _result} ->
        json conn |> put_status(:bad_request),
                     %{errors: ["unable to update user"]}
    end
  end

  def index(conn, _params) do
    users = Repo.all(CrossSocialMediasApi.User)
    json conn_with_status(conn, users), users
  end

  def show(conn, %{"id" => id}) do
    user = Repo.get(CrossSocialMediasApi.User, String.to_integer(id))

    json conn_with_status(conn, user), user
  end

  def create(conn, params) do
    changeset = CrossSocialMediasApi.User.changeset(
      %CrossSocialMediasApi.User{}, params)

    case Repo.insert(changeset) do
          {:ok, user} ->
            json conn |> put_status(:created), user
          {:error, _changeset} ->
            json conn |> put_status(:bad_request), %{errors: ["unable to create user"] }
    end
  end

  def update(conn, %{"id" => id} = params) do
    user = Repo.get(CrossSocialMediasApi.User, id)
    if user do
      perform_update(conn, user, params)
    else
      json conn |> put_status(:not_found),
                   %{errors: ["invalid user"] }
    end
  end
end