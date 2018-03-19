defmodule CrossSocialMediasApi.SocialMediaMappingTest do
  use CrossSocialMediasApi.ModelCase

  alias CrossSocialMediasApi.SocialMediaMapping

  @valid_attrs %{mapping_name: "Anthony Lastella", twitter_username: "AnthonyLastella", instagram_username: "anthonylastella", youtube_channel_id: "13245679847", user_id: 2}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = SocialMediaMapping.changeset(%SocialMediaMapping{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = SocialMediaMapping.changeset(%SocialMediaMapping{}, @invalid_attrs)
    refute changeset.valid?
  end

  test "mapping_name, twitter_username, user_id are required" do
    changeset = SocialMediaMapping.changeset(%SocialMediaMapping{}, Map.delete(@valid_attrs, :mapping_name))
    refute changeset.valid?

    changeset_2 = SocialMediaMapping.changeset(%SocialMediaMapping{}, Map.delete(@valid_attrs, :twitter_username))
    refute changeset_2.valid?

    changeset_3 = SocialMediaMapping.changeset(%SocialMediaMapping{}, Map.delete(@valid_attrs, :user_id))
    refute changeset_3.valid?
  end

end