defmodule CrossSocialMediasApi.SocialMediaMappingControllerTest do
  use CrossSocialMediasApi.ConnCase

  alias CrossSocialMediasApi.{Repo, SocialMediaMapping, User}

  setup do
    user = Repo.insert!(User.registration_changeset(%User{}, %{ name: "Test", email: "test@example.com", password: "fakePassword", username: "testAuth"}))
    {:ok, jwt, full_claims} = Guardian.encode_and_sign(user)
    {:ok, %{user: user, jwt: jwt, claims: full_claims}}
  end

  describe "index/2" do
    test "responds with all mappings", %{jwt: jwt}  do
      user_1 = Repo.insert!(User.changeset(%User{}, %{ name: "John", email: "john@example.com", password: "fake", username: "Jojo"}))
      social_media_mappings = [
        SocialMediaMapping.changeset(%SocialMediaMapping{}, %{mapping_name: "Anthony Lastella", twitter_username: "AnthonyLastella", instagram_username: "anthonyLastella", youtube_channel_id: "123465", created_by: user_1.id, user_id: user_1.id}),
        SocialMediaMapping.changeset(%SocialMediaMapping{}, %{mapping_name: "John doe", twitter_username: "johnDoe", instagram_username: "JoJo", youtube_channel_id: "123465", created_by: user_1.id, user_id: user_1.id})
      ]

      Enum.each(social_media_mappings, &Repo.insert!(&1))

      response = build_conn()
        |> put_req_header("authorization", "Bearer #{jwt}")
        |> get(social_media_mapping_path(build_conn(), :index))
        |> json_response(200)

      expected = %{
        "data" => [
          %{ "mapping_name" => "Anthony Lastella", "twitter_username" => "AnthonyLastella", "instagram_username" => "anthonyLastella", "youtube_channel_id" => "123465", "created_by" => user_1.id },
          %{ "mapping_name" => "John doe", "twitter_username" => "johnDoe", "instagram_username" => "JoJo", "youtube_channel_id" => "123465", "created_by" => user_1.id }
        ]
      }

      assert response == expected
    end
  end


  describe "create/2" do
    test "Creates, and responds with a newly created mapping if attributes are valid", %{jwt: jwt} do
      user_1 = Repo.insert!(User.changeset(%User{}, %{ name: "John", email: "john@example.com", password: "fake", username: "Jojo"}))
      response = build_conn()
        |> put_req_header("authorization", "Bearer #{jwt}")
        |> post(social_media_mapping_path(build_conn(), :create, %{mapping_name: "John doe", twitter_username: "johnDoe", instagram_username: "JoJo", youtube_channel_id: "123465", created_by: user_1.id, user_id: user_1.id}))
        |> json_response(201)

      expected = %{ "data" => %{ "mapping_name" => "John doe", "twitter_username" => "johnDoe", "instagram_username" => "JoJo", "youtube_channel_id" => "123465", "created_by" => user_1.id } }

      assert response == expected
    end

    test "Returns an error and does not create a mapping if attributes are invalid", %{jwt: jwt} do
      response = build_conn()
        |> put_req_header("authorization", "Bearer #{jwt}")
        |> post(social_media_mapping_path(build_conn(), :create, %{twitter_username: "JohnDoe"}))
        |> json_response(:bad_request)

      expected = %{"errors" =>["unable to create mapping"]}

      assert response == expected
    end
  end

  describe "show/2" do
    test "Responds with a newly created mapping if the mapping is found", %{jwt: jwt} do
      user_1 = Repo.insert!(User.changeset(%User{}, %{ name: "John", email: "john@example.com", password: "fake", username: "Jojo"}))
      social_media_mapping = SocialMediaMapping.changeset(%SocialMediaMapping{}, %{mapping_name: "Anthony Lastella", twitter_username: "AnthonyLastella", instagram_username: "anthonyLastella", youtube_channel_id: "123465", created_by: user_1.id, user_id: user_1.id })
        |> Repo.insert!

      response = build_conn()
        |> put_req_header("authorization", "Bearer #{jwt}")
        |> get(social_media_mapping_path(build_conn(), :show, social_media_mapping.id))
        |> json_response(200)

      expected = %{ "data" => %{ "mapping_name" => "Anthony Lastella", "twitter_username" => "AnthonyLastella", "instagram_username" => "anthonyLastella", "youtube_channel_id" => "123465", "created_by" => user_1.id } }

      assert response == expected
    end

    test "Responds with a message indicating mapping not found", %{jwt: jwt} do
      response = build_conn()
        |> put_req_header("authorization", "Bearer #{jwt}")
        |> get(social_media_mapping_path(build_conn(), :show, 300))
        |> json_response(404)

      expected = %{ "error" => "mapping not found." }

      assert response == expected
    end
  end


  describe "update/2" do
    test "Edits, and responds with the user if attributes are valid", %{jwt: jwt} do
      user_1 = Repo.insert!(User.changeset(%User{}, %{ name: "John", email: "john@example.com", password: "fake", username: "Jojo"}))
      social_media_mapping = SocialMediaMapping.changeset(%SocialMediaMapping{}, %{mapping_name: "John", twitter_username: "AnthonyLastella", instagram_username: "anthonyLastella", youtube_channel_id: "123465", created_by: user_1.id, user_id: user_1.id})
        |> Repo.insert!

      response = build_conn()
        |> put_req_header("authorization", "Bearer #{jwt}")
        |> put(social_media_mapping_path(build_conn(), :update, social_media_mapping.id, mapping_name: "Jane"))
        |> json_response(200)

      expected = %{"data" => %{ "mapping_name" => "Jane", "twitter_username" => "AnthonyLastella", "instagram_username" => "anthonyLastella", "youtube_channel_id" => "123465", "created_by" => user_1.id } }

      assert response == expected
    end
  end

  describe "search/2" do
    test "search a mapping name, should return two records", %{user: user, jwt: jwt} do
      social_media_mappings = [
        SocialMediaMapping.changeset(%SocialMediaMapping{}, %{mapping_name: "Anthony Lastella", twitter_username: "AnthonyLastella", instagram_username: "anthonyLastella", youtube_channel_id: "123465", created_by: user.id, user_id: user.id}),
        SocialMediaMapping.changeset(%SocialMediaMapping{}, %{mapping_name: "John doe", twitter_username: "johnDoe", instagram_username: "JoJo", youtube_channel_id: "123465", created_by: user.id, user_id: user.id}),
        SocialMediaMapping.changeset(%SocialMediaMapping{}, %{mapping_name: "super John", twitter_username: "john", instagram_username: "Jo", youtube_channel_id: "123465", created_by: user.id, user_id: user.id}),
        SocialMediaMapping.changeset(%SocialMediaMapping{}, %{mapping_name: "Bar", twitter_username: "Bar", instagram_username: "Bar", youtube_channel_id: "123465", created_by: user.id, user_id: user.id}),
        SocialMediaMapping.changeset(%SocialMediaMapping{}, %{mapping_name: "Foo", twitter_username: "Foo", instagram_username: "Foo", youtube_channel_id: "123465", created_by: user.id, user_id: user.id})
      ]
      Enum.each(social_media_mappings, &Repo.insert!(&1))

      response = build_conn()
        |> put_req_header("authorization", "Bearer #{jwt}")
        |> get(social_media_mapping_path(build_conn(), :search, mapping_name: "John"))
        |> json_response(200)

      expected = %{
        "data" => [
          %{
            "created_by" => user.id,
            "instagram_username" => "JoJo",
            "mapping_name" => "John doe",
            "twitter_username" => "johnDoe",
            "youtube_channel_id" => "123465"
          },
          %{
            "created_by" => user.id,
            "instagram_username" => "Jo",
            "mapping_name" => "super John",
            "twitter_username" => "john",
            "youtube_channel_id" => "123465"
          }
        ]
      }
      assert response == expected
    end

    test "search a mapping, should return an empty array", %{user: user, jwt: jwt} do
      social_media_mappings = [
        SocialMediaMapping.changeset(%SocialMediaMapping{}, %{mapping_name: "Anthony Lastella", twitter_username: "AnthonyLastella", instagram_username: "anthonyLastella", youtube_channel_id: "123465", created_by: user.id, user_id: user.id}),
        SocialMediaMapping.changeset(%SocialMediaMapping{}, %{mapping_name: "John doe", twitter_username: "johnDoe", instagram_username: "JoJo", youtube_channel_id: "123465", created_by: user.id, user_id: user.id}),
        SocialMediaMapping.changeset(%SocialMediaMapping{}, %{mapping_name: "super John", twitter_username: "john", instagram_username: "Jo", youtube_channel_id: "123465", created_by: user.id, user_id: user.id}),
        SocialMediaMapping.changeset(%SocialMediaMapping{}, %{mapping_name: "Bar", twitter_username: "Bar", instagram_username: "Bar", youtube_channel_id: "123465", created_by: user.id, user_id: user.id}),
        SocialMediaMapping.changeset(%SocialMediaMapping{}, %{mapping_name: "Foo", twitter_username: "Foo", instagram_username: "Foo", youtube_channel_id: "123465", created_by: user.id, user_id: user.id})
      ]
      Enum.each(social_media_mappings, &Repo.insert!(&1))

      response = build_conn()
        |> put_req_header("authorization", "Bearer #{jwt}")
        |> get(social_media_mapping_path(build_conn(), :search, mapping_name: "Wrong research"))
        |> json_response(200)

      expected = %{ "data" => []}
      assert response == expected
    end
  end

end
