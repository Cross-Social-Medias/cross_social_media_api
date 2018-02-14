defmodule CrossSocialMediasApi.Repo do
  use Ecto.Repo, otp_app: :cross_social_medias_api
  
	def users() do
    [
      %CrossSocialMediasApi.User{id: 1,
                       name: "Joe",
                       email: "joe@example.com",
                       password: "topsecret",
                       stooge: "moe"},

      %CrossSocialMediasApi.User{id: 2,
                       name: "Anne",
                       email: "anne@example.com",
                       password: "guessme",
                       stooge: "larry"},

      %CrossSocialMediasApi.User{id: 3,
                       name: "Franklin",
                       email: "franklin@example.com",
                       password: "guessme",
                       stooge: "curly"},

    ]
  end

  def get_user(id) do
    Enum.find users(), fn elem -> elem.id == id end
  end
end
