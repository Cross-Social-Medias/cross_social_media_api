# web/models.user.ex
defmodule CrossSocialMediasApi.User do
  use CrossSocialMediasApi.Web, :model

  schema "users" do
    field :name, :string
    field :email, :string
    field :password, :string
    field :stooge, :string

    timestamps
  end
end