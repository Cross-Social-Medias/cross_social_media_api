defmodule CrossSocialMediasApi.UserControllerTest do
  use CrossSocialMediasApi.ConnCase

  alias CrossSocialMediasApi.{Repo, User}

  describe "index/2" do
    test "responds with all Users" do
      users = [ User.changeset(%User{}, %{name: "John", email: "john@example.com", password: "fake", stooge: "Jojo"}),
                User.changeset(%User{}, %{name: "Jane", email: "jane@example.com", password: "fake"}) ]

      Enum.each(users, &Repo.insert!(&1))

      response = build_conn()
        |> get(user_path(build_conn(), :index))
        |> json_response(200)

      expected = %{
        "data" => [
          %{ "name" => "John", "email" => "john@example.com", "stooge" => "Jojo" },
          %{ "name" => "Jane", "email" => "jane@example.com", "stooge" => nil }
        ]
      }

      assert response == expected
    end
  end


  describe "create/2" do
    test "Creates, and responds with a newly created user if attributes are valid" do
      response = build_conn()
        |> post(user_path(build_conn(), :create, %{name: "John", email: "john@example.com", password: "fake"}))
        |> json_response(201)

      expected = %{ "data" => %{ "name" => "John", "email" => "john@example.com", "stooge" => nil } }

      assert response == expected
    end

    test "Returns an error and does not create a user if attributes are invalid" do
          response = build_conn()
        |> post(user_path(build_conn(), :create, %{name: "John"}))
        |> json_response(:bad_request)

      expected = %{"errors" =>["unable to create user"]}

      assert response == expected  
    end
  end

  describe "show/2" do
    test "Responds with a newly created user if the user is found" do
      user = User.changeset(%User{}, %{name: "John", email: "john@example.com", password: "fake"})
        |> Repo.insert!

      response = build_conn()
        |> get(user_path(build_conn(), :show, user.id))
        |> json_response(200)

      expected = %{ "data" => %{ "name" => "John", "email" => "john@example.com", "stooge" => nil } }

      assert response == expected
    end

    test "Responds with a message indicating user not found" do
      response = build_conn()
        |> get(user_path(build_conn(), :show, 300))
        |> json_response(404)

      expected = %{ "error" => "User not found." }

      assert response == expected
    end
  end


  describe "update/2" do
    test "Edits, and responds with the user if attributes are valid" do
      user = User.changeset(%User{}, %{name: "John", email: "john@example.com", password: "fake"})
        |> Repo.insert!

      response = build_conn()
        |> put(user_path(build_conn(), :update, user.id, name: "Jane"))
        |> json_response(200)

      expected = %{  "data" => %{"name" => "Jane", "email" => "john@example.com", "stooge" => nil} }

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
