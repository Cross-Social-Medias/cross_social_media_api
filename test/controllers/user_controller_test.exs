defmodule CrossSocialMediasApi.UserControllerTest do
  use CrossSocialMediasApi.ConnCase

  alias CrossSocialMediasApi.{Repo, User}

  setup do
    user = Repo.insert!(User.registration_changeset(%User{}, %{ name: "Test", email: "test@example.com", password: "fakePassword", stooge: "testAuth"}))
    {:ok, jwt, full_claims} = Guardian.encode_and_sign(user)
    {:ok, %{user: user, jwt: jwt, claims: full_claims}}
  end


  describe "index/2" do
    test "responds with all Users", %{jwt: jwt} do
      user_1 = Repo.insert!(User.changeset(%User{}, %{ name: "John", email: "john@example.com", password: "fake", stooge: "Jojo"}))
      user_2 = Repo.insert!(User.changeset(%User{}, %{ name: "Jane", email: "jane@example.com", password: "fake"}))

      response = build_conn()
        |> put_req_header("authorization", "Bearer #{jwt}")
        |> get(user_path(build_conn(), :index))
        |> json_response(200)

      expected = %{
        "data" => [
          %{ "id" => (user_1.id - 1), "name" => "Test", "email" => "test@example.com", "stooge" => "testAuth" },
          %{ "id" => user_1.id, "name" => "John", "email" => "john@example.com", "stooge" => "Jojo" },
          %{ "id" => user_2.id, "name" => "Jane", "email" => "jane@example.com", "stooge" => nil }
        ]
      }

      assert response == expected
    end
  end


  describe "create/2" do
    test "Creates, and responds with a newly created user if attributes are valid", %{jwt: jwt} do
      response = build_conn()
        |> put_req_header("authorization", "Bearer #{jwt}")
        |> post(user_path(build_conn(), :create, %{ name: "John", email: "john@example.com", password: "fakePassword"}))
        |> json_response(201)

      expected = %{ "data" => %{ "id" => response["data"]["id"], "name" => "John", "email" => "john@example.com", "stooge" => nil } }

      assert response == expected
    end

    test "Returns an error and does not create a user if attributes are invalid", %{jwt: jwt} do
      response = build_conn()
        |> put_req_header("authorization", "Bearer #{jwt}")
        |> post(user_path(build_conn(), :create, %{name: "John"}))
        |> json_response(:bad_request)

      expected = %{"errors" =>["unable to create user"]}

      assert response == expected  
    end
  end

  describe "show/2" do
    test "Responds with a newly created user if the user is found", %{jwt: jwt} do
      user = User.changeset(%User{}, %{ name: "John", email: "john@example.com", password: "fake"})
        |> Repo.insert!

      response = build_conn()
        |> put_req_header("authorization", "Bearer #{jwt}")
        |> get(user_path(build_conn(), :show, user.id))
        |> json_response(200)

      expected = %{ "data" => %{ "id" => user.id, "name" => "John", "email" => "john@example.com", "stooge" => nil } }

      assert response == expected
    end

    test "Responds with a message indicating user not found", %{jwt: jwt} do
      response = build_conn()
        |> put_req_header("authorization", "Bearer #{jwt}")
        |> get(user_path(build_conn(), :show, 300))
        |> json_response(404)

      expected = %{ "error" => "User not found." }

      assert response == expected
    end
  end


  describe "update/2" do
    test "Edits, and responds with the user if attributes are valid", %{jwt: jwt} do
      user = User.changeset(%User{}, %{ name: "John", email: "john@example.com", password: "fake"})
        |> Repo.insert!

      response = build_conn()
        |> put_req_header("authorization", "Bearer #{jwt}")
        |> put(user_path(build_conn(), :update, user.id, name: "Jane"))
        |> json_response(200)

      expected = %{  "data" => %{"id" => user.id, "name" => "Jane", "email" => "john@example.com", "stooge" => nil} }

      assert response == expected
    end

    # test "Returns an error and does not edit the user if attributes are invalid" do
    #   user = User.changeset(%User{}, %{name: "John", email: "john@example.com", password: "fake"})
    #     |> Repo.insert!

    #   response = build_conn()
    #     |> put(user_path(build_conn(), :update, user.id, name: 32))
    #     |> json_response(:bad_request)

    #   expected = %{  "errors" => ["unable to update user"] }

    #   assert response == expected
    # end
  end

end
