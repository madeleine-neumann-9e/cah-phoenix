defmodule PlatformWeb.GameController do
  use PlatformWeb, :controller

  alias Platform.Games

  def index(conn, _params) do
    game =
      Games.new()
      |> Games.add_player("Sascha")
      |> Games.add_player("Madeleine")

    render(conn, "index.html", room: game)
  end
end
