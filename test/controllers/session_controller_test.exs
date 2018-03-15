defmodule CrossSocialMediasApi.SessionControllerTest do
  use CrossSocialMediasApi.ConnCase

  alias CrossSocialMediasApi.{Repo, User}

  describe "log_in/2" do
    test "should logged in" do
      user = Repo.insert!(User.validate_changeset(%User{}, %{ name: "John", email: "john@example.com", password: "MySuperPa55", username: "Jojo"}))
      response = build_conn()
        |> post(session_path(build_conn(), :sign_in,
          %{
            email: user.email,
            password: "MySuperPa55"
          }
        ))
        |> json_response(200)

      expected = %{
        "message" => "You are successfully logged in! Add this token to authorization header to make authorized requests.",
        "user" => %{ "name" => "John", "email" => "john@example.com", "id" => response["user"]["id"], "username" => "Jojo"},
        "token" => response["token"]
        
      }
      assert response == expected
    end

    test "should NOT sign_in because the user does not exist" do
      response = build_conn()
        |> post(session_path(build_conn(), :sign_in, 
          %{
            email: "hello@world.com",
            password: "MySuperPa55"
          }
        ))
        |> json_response(401)

      expected = %{"message" => "Could not sign in"}
      assert response == expected
    end
  end
end
