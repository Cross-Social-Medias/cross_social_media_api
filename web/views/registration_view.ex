defmodule CrossSocialMediasApi.RegistrationView do
  use CrossSocialMediasApi.Web, :view

  def render("success.json", %{user: _user}) do
    %{
      status: :ok,
      message: """
        Now you can sign in using your email and password at /api/sign_in. You will receive JWT token.
        Please put this token into Authorization header for all authorized requests.
      """
    }
  end

  def render("error.json", _changeset) do
    %{ 
      status: :unprocessable_entity,
      message: "User cannot be created"
    }
  end
end