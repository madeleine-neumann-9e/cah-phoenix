defmodule PlatformWeb.PageController do
  use PlatformWeb, :controller

  def index(conn, _params) do

    render(conn, "index.html", room: nil)
  end
end
