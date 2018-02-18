defmodule CrossSocialMediasApi.UserControllerTest do
  use CrossSocialMediasApi.ConnCase

  alias CrossSocialMediasApi.{Repo, User}

  
  test "index/2 responds with all Users" do
    users = [ User.changeset(%User{}, %{name: "John", email: "john@example.com", password: "fake", stooge: "Jojo"}),
              User.changeset(%User{}, %{name: "Jane", email: "jane@example.com", password: "fake"}) ]

    Enum.each(users, &Repo.insert!(&1))

    response = build_conn()
      |> get(user_path(build_conn, :index))
      |> json_response(200)

    expected = %{
      "data" => [
        %{ "name" => "John", "email" => "john@example.com", "stooge" => "Jojo" },
        %{ "name" => "Jane", "email" => "jane@example.com", "stooge" => nil }
      ]
    }

    assert response == expected
  end


  describe "create/2" do
    test "Creates, and responds with a newly created user if attributes are valid"
    test "Returns an error and does not create a user if attributes are invalid"
  end

  test "show/2 Reponds with a newly created user if the user is found" do
    user = User.changeset(%User{}, %{name: "John", email: "john@example.com", password: "fake"})
      |> Repo.insert!

    response = build_conn()
      |> get(user_path(build_conn, :show, user.id))
      |> json_response(200)

    expected = %{ "data" => %{ "name" => "John", "email" => "john@example.com", "stooge" => nil } }

    assert response == expected
  end

  describe "update/2" do
    test "Edits, and responds with the user if attributes are valid"
    test "Returns an error and does not edit the user if attributes are invalid"
  end

  test "delete/2 and responds with :ok if the user was deleted"

end
