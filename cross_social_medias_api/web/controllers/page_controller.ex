defmodule CrossSocialMediasApi.PageController do
  use CrossSocialMediasApi.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
