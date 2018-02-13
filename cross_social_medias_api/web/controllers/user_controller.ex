# web/controllers/user_controller
defmodule CrossSocialMediasApi.UserController do
  use CrossSocialMediasApi.Web, :controller

def index(conn, _params) do
    users = [
      %ApiExample.User{ id: 1,
                        name: "Joe",
                        email: "joe@example.com",
                        password: "topsecret",
                        stooge: "moe"},

      %ApiExample.User{ id: 2,
                        name: "Anne",
                        email: "anne@example.com",
                        password: "guessme",
                        stooge: "larry"},

      %ApiExample.User{ id: 3,
                        name: "Franklin",
                        email: "franklin@example.com",
                        password: "guessme",
                        stooge: "curly"},

    ]

    json conn, users
  end
end