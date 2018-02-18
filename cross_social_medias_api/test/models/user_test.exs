defmodule CrossSocialMediasApi.UserTest do
  use CrossSocialMediasApi.ModelCase

  alias CrossSocialMediasApi.User

  @valid_attrs %{name: "John", email: "john@email.com", password: "password", stooge: "Jojo"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = User.changeset(%User{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = User.changeset(%User{}, @invalid_attrs)
    refute changeset.valid?
  end

  test "stooge is not required" do
    changeset = User.changeset(%User{}, Map.delete(@valid_attrs, :stooge))
    assert changeset.valid?
  end

  test "name, email, and password is required" do
    changeset = User.changeset(%User{}, Map.delete(@valid_attrs, :name))
    refute changeset.valid?

    changeset_2 = User.changeset(%User{}, Map.delete(@valid_attrs, :email))
    refute changeset_2.valid?

    changeset_3 = User.changeset(%User{}, Map.delete(@valid_attrs, :password))
    refute changeset_3.valid?

  end

end