defmodule CrossSocialMediasApi.SessionView do
  use CrossSocialMediasApi.Web, :view

  def render("sign_in.json", %{user: user, jwt: jwt}) do
    %{
      token: jwt,
      user: render_one(user, CrossSocialMediasApi.UserView, "user.json"),
      message: "You are successfully logged in! Add this token to authorization header to make authorized requests."
    }
  end

  def render("error.json", _message) do
    %{ 
      message: "Could not sign in"
    }
  end
end