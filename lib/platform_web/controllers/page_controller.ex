defmodule PlatformWeb.PageController do
  use PlatformWeb, :controller
  alias Platform.Games

  def index(conn, _params) do
    changeset = Games.change(%{})
    render(conn, "index.html", changeset: changeset)
  end
end
