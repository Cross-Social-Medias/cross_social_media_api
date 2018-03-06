defmodule CrossSocialMediasApi.SocialMediaMappingControllerTest do
  use CrossSocialMediasApi.ConnCase

  alias CrossSocialMediasApi.{Repo, SocialMediaMapping, User}

  describe "index/2" do
    test "responds with all mappings" do
      user_1 = Repo.insert!(User.changeset(%User{}, %{ name: "John", email: "john@example.com", password: "fake", stooge: "Jojo"}))
      social_media_mappings = [ SocialMediaMapping.changeset(%SocialMediaMapping{}, %{mapping_name: "Anthony Lastella", twitter_username: "AnthonyLastella", instagram_username: "anthonyLastella", created_by: user_1.id, user_id: user_1.id}),
                SocialMediaMapping.changeset(%SocialMediaMapping{}, %{mapping_name: "John doe", twitter_username: "johnDoe", instagram_username: "JoJo", created_by: user_1.id, user_id: user_1.id}) ]

      Enum.each(social_media_mappings, &Repo.insert!(&1))

      response = build_conn()
        |> get(social_media_mapping_path(build_conn(), :index))
        |> json_response(200)

      expected = %{
        "data" => [
          %{ "mapping_name" => "Anthony Lastella", "twitter_username" => "AnthonyLastella", "instagram_username" => "anthonyLastella", "created_by" => user_1.id },
          %{ "mapping_name" => "John doe", "twitter_username" => "johnDoe", "instagram_username" => "JoJo", "created_by" => user_1.id }
        ]
      }

      assert response == expected
    end
  end


  describe "create/2" do
    test "Creates, and responds with a newly created mapping if attributes are valid" do
      user_1 = Repo.insert!(User.changeset(%User{}, %{ name: "John", email: "john@example.com", password: "fake", stooge: "Jojo"}))
      response = build_conn()
        |> post(social_media_mapping_path(build_conn(), :create, %{mapping_name: "John doe", twitter_username: "johnDoe", instagram_username: "JoJo", created_by: user_1.id, user_id: user_1.id}))
        |> json_response(201)

      expected = %{ "data" => %{ "mapping_name" => "John doe", "twitter_username" => "johnDoe", "instagram_username" => "JoJo", "created_by" => user_1.id } }

      assert response == expected
    end

    test "Returns an error and does not create a mapping if attributes are invalid" do
          response = build_conn()
        |> post(social_media_mapping_path(build_conn(), :create, %{twitter_username: "JohnDoe"}))
        |> json_response(:bad_request)

      expected = %{"errors" =>["unable to create mapping"]}

      assert response == expected
    end
  end

  describe "show/2" do
    test "Responds with a newly created mapping if the mapping is found" do
      user_1 = Repo.insert!(User.changeset(%User{}, %{ name: "John", email: "john@example.com", password: "fake", stooge: "Jojo"}))
      social_media_mapping = SocialMediaMapping.changeset(%SocialMediaMapping{}, %{mapping_name: "Anthony Lastella", twitter_username: "AnthonyLastella", instagram_username: "anthonyLastella", created_by: user_1.id, user_id: user_1.id })
        |> Repo.insert!

      response = build_conn()
        |> get(social_media_mapping_path(build_conn(), :show, social_media_mapping.id))
        |> json_response(200)

      expected = %{ "data" => %{ "mapping_name" => "Anthony Lastella", "twitter_username" => "AnthonyLastella", "instagram_username" => "anthonyLastella", "created_by" => user_1.id } }

      assert response == expected
    end

    test "Responds with a message indicating mapping not found" do
      response = build_conn()
        |> get(social_media_mapping_path(build_conn(), :show, 300))
        |> json_response(404)

      expected = %{ "error" => "mapping not found." }

      assert response == expected
    end
  end


  describe "update/2" do
    test "Edits, and responds with the user if attributes are valid" do
      user_1 = Repo.insert!(User.changeset(%User{}, %{ name: "John", email: "john@example.com", password: "fake", stooge: "Jojo"}))
      social_media_mapping = SocialMediaMapping.changeset(%SocialMediaMapping{}, %{mapping_name: "John", twitter_username: "AnthonyLastella", instagram_username: "anthonyLastella", created_by: user_1.id, user_id: user_1.id})
        |> Repo.insert!

      response = build_conn()
        |> put(social_media_mapping_path(build_conn(), :update, social_media_mapping.id, mapping_name: "Jane"))
        |> json_response(200)

      expected = %{"data" => %{ "mapping_name" => "Jane", "twitter_username" => "AnthonyLastella", "instagram_username" => "anthonyLastella", "created_by" => user_1.id } }

      assert response == expected
    end
  end

end
