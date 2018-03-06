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

  def registration_changeset(model, params) do
    model
    |> changeset(params)
    |> cast(params, ~w(password)a, [])
    |> validate_length(:password, min: 6, max: 100)
    |> hash_password
  end

  defp hash_password(changeset) do
    case changeset do
      %Ecto.Changeset{valid?: true,
                      changes: %{password: password}} ->
        put_change(changeset,
                   :password_hash,
                   Comeonin.Bcrypt.hashpwsalt(password))
      _ ->
        changeset
    end
  end
end