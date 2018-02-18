defmodule CrossSocialMediasApi.UserView do
  use CrossSocialMediasApi.Web, :view

  def render("index.json", %{users: users}) do
    %{data: render_many(users, CrossSocialMediasApi.UserView, "user.json")}
  end

  def render("user.json", %{user: user}) do
    %{name: user.name, email: user.email, stooge: user.stooge}
  end

  def render("show.json", %{user: user}) do
    %{data: render_one(user, CrossSocialMediasApi.UserView, "user.json")}
  end

end