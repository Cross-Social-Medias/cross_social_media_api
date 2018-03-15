defmodule CrossSocialMediasApi.RegistrationControllerTest do
  use CrossSocialMediasApi.ConnCase

  describe "sign_up/2" do
    test "should sign_up" do
      response = build_conn()
        |> post(registration_path(build_conn(), :sign_up,
          %{ user:
            %{ email: "hello@world.com",
               name: "John Doe",
               phone: "033-64-22",
               password: "MySuperPa55"
            }
          }
        ))
        |> json_response(201)

      expected = %{"message" => "  Now you can sign in using your email and password at /api/sign_in. You will receive JWT token.\n  Please put this token into Authorization header for all authorized requests.\n", "status" => "ok"}
      assert response == expected
    end

    test "should NOT sign_up" do
      response = build_conn()
        |> post(registration_path(build_conn(), :sign_up, %{ user: %{ name: "John"}}
        ))
        |> json_response(422)

      expected = %{"message" => %{"email" => ["can't be blank"], "password" => ["can't be blank"]}, "status" => "unprocessable_entity"}
      assert response == expected
    end
  end
end
