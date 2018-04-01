defmodule CrossSocialMediasApi.UserTest do
  use CrossSocialMediasApi.ModelCase

  alias CrossSocialMediasApi.{User, Repo, SocialMediaMapping}

  @valid_attrs %{name: "John", email: "john@email.com", password: "password", username: "Jojo"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = User.changeset(%User{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = User.changeset(%User{}, @invalid_attrs)
    refute changeset.valid?
  end

  test "username is not required" do
    changeset = User.changeset(%User{}, Map.delete(@valid_attrs, :username))
    assert changeset.valid?
  end

  test "name, email, and password are required" do
    changeset = User.changeset(%User{}, Map.delete(@valid_attrs, :name))
    refute changeset.valid?

    changeset_2 = User.changeset(%User{}, Map.delete(@valid_attrs, :email))
    refute changeset_2.valid?

    changeset_3 = User.changeset(%User{}, Map.delete(@valid_attrs, :password))
    refute changeset_3.valid?
  end

  test "check password constraint" do
    changeset = User.registration_changeset(%User{}, %{name: "John", email: "john@email.com", username: "jojo", password: "short"})
    refute changeset.valid?

    changeset_2 = User.registration_changeset(%User{}, @valid_attrs)
    assert changeset_2.valid?
  end

  test "get my social media mappings" do
    user = Repo.insert!(User.changeset(%User{}, %{ name: "John", email: "john@example.com", password: "fake", username: "Jojo"}))
    user_2 = Repo.insert!(User.changeset(%User{}, %{ name: "John2", email: "john2@example.com", password: "fake", username: "Jojo"}))
    social_media_mappings_1 = Repo.insert!(SocialMediaMapping.changeset(%SocialMediaMapping{}, %{mapping_name: "Anthony Lastella", twitter_username: "AnthonyLastella", instagram_username: "anthonyLastella", youtube_channel_id: "123465", user_id: user.id}))
    social_media_mappings_2 = Repo.insert!(SocialMediaMapping.changeset(%SocialMediaMapping{}, %{mapping_name: "John doe", twitter_username: "johnDoe", instagram_username: "JoJo", youtube_channel_id: "123465", user_id: user.id}))
    social_media_mappings_3 = Repo.insert!(SocialMediaMapping.changeset(%SocialMediaMapping{}, %{mapping_name: "third", twitter_username: "third", instagram_username: "third", youtube_channel_id: "123465", user_id: user_2.id}))

    assert User.my_social_media_mappings(user) == [social_media_mappings_1, social_media_mappings_2]
    assert User.my_social_media_mappings(user_2) == [social_media_mappings_3]
  end

end