# web/models.user.ex
import Ecto.Query, only: [from: 2]

defmodule CrossSocialMediasApi.User do
  use CrossSocialMediasApi.Web, :model

  alias CrossSocialMediasApi.{Repo, User}

  schema "users" do
    field :name, :string
    field :email, :string
    field :password, :string
    field :username, :string

    has_many :social_media_mappings, CrossSocialMediasApi.SocialMediaMapping

    timestamps()
  end

  def changeset(model, params \\ :empty) do
    model
      |> cast(params, [:name, :email, :password, :username])
      |> validate_required([:name, :password, :email])
  end

  def registration_changeset(model, params \\ :empty) do
    model
    |> cast(params, [:email, :name, :password])
    |> validate_required([:email, :name, :password])
    |> validate_changeset(params)
  end

  def validate_changeset(model, params) do
    model
    |> changeset(params)
    |> cast(params, ~w(password)a, [])
    |> validate_length(:password, min: 6, max: 100)
    |> hash_password
  end

  def find_and_confirm_password(email, password) do
    case Repo.get_by(User, email: email) do
      nil ->
        {:error, :not_found}
      user ->
        if Comeonin.Bcrypt.checkpw(password, user.password) do
          {:ok, user}
        else
          {:error, :unauthorized}
        end
    end
  end

  defp hash_password(changeset) do
    case changeset do
      %Ecto.Changeset{valid?: true,
                      changes: %{password: password}} ->
        put_change(changeset,
                   :password,
                   Comeonin.Bcrypt.hashpwsalt(password))
      _ ->
        changeset
    end
  end

  def my_social_media_mappings(model) do
    Repo.all from mappings in CrossSocialMediasApi.SocialMediaMapping,
    where: mappings.user_id == ^model.id
  end

end