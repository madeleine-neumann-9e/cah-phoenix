defmodule PlatformWeb.PageController do
  use PlatformWeb, :controller

  alias Platform.Game.Room

  def index(conn, _params) do
    room = Room.new()

    render(conn, "index.html", room: room)
  end
end
