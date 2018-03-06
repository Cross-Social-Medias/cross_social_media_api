# web/models.user.ex
defmodule CrossSocialMediasApi.User do
  use CrossSocialMediasApi.Web, :model

  schema "users" do
    field :name, :string
    field :email, :string
    field :password, :string
    field :stooge, :string

    has_many :social_media_mappings, CrossSocialMediasApi.SocialMediaMapping

    timestamps()
  end

  def changeset(model, params \\ :empty) do
    model
      |> cast(params, [:name, :email, :password, :stooge])
      |> validate_required([:name, :password, :email])
  end
end