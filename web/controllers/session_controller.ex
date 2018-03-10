defmodule CrossSocialMediasApi.SessionController do
  use CrossSocialMediasApi.Web, :controller

  alias CrossSocialMediasApi.User

  def sign_in(conn, %{"email" => email, "password" => password}) do
    case User.find_and_confirm_password(email, password) do
      {:ok, user} ->
         {:ok, jwt, _full_claims} = Guardian.encode_and_sign(user, :api)

         conn
         |> put_status(200)
         |> render("sign_in.json", user: user, jwt: jwt)
      {:error, _reason} ->
        conn
        |> put_status(401)
        |> render("error.json", message: "Could not login")
    end
  end 

  # def delete(conn, params) do
  # jsonwt = Guardian.Plug.current_token(conn)
  #   Guardian.revoke!(jwt)
  # respond_somehow(conn)
  # end 

  # def sign_in(conn, %{"session" => %{"email" => email, "password" => password}}) do  
  #   case User.find_and_confirm_password(email, password) do
  #     {:ok, user} ->
  #       new_conn = Guardian.Plug.api_sign_in(conn, user)
  #       jwt = Guardian.Plug.current_token(new_conn)
  #       claims = Guardian.Plug.claims(new_conn)
  #       exp = Map.get(claims, "exp")

  #       new_conn
  #       |> put_resp_header("authorization", "Bearer #{jwt}")
  #       |> put_resp_header("x-expires", exp)
  #       |> render("sign_in.json", user: user, jwt: jwt, exp: exp)
  #     {:error, _reason} ->
  #       conn
  #       |> put_status(401)
  #       |> render("error.json", message: "Could not login")
  #   end
  # end

end