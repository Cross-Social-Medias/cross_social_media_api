defmodule CrossSocialMediasApi.SessionView do
  use CrossSocialMediasApi.Web, :view

  def render("sign_in.json", %{user: user, jwt: jwt}) do
    %{
      status: :ok,
      data: %{
        token: jwt,
        email: user.email
      },
      message: "You are successfully logged in! Add this token to authorization header to make authorized requests."
    }
  end

  def render("error.json", _message) do
    %{ 
      status: :unprocessable_entity,
      message: "Could not sign in"
    }
  end
end