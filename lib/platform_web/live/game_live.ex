defmodule Platform.GameLive do
  use Phoenix.LiveView
  alias Platform.Games

  def render(assigns), do: PlatformWeb.PageView.render("_game.html", assigns)

  def mount(_params, %{}, socket) do
    game =
      Games.new()
      |> Games.add_player("Sascha")

    {:ok, assign(socket, :game, game)}
  end


  def handle_event("add_player", %{}, socket) do
    new_game =
      socket.assigns.game
      |> Games.add_player("Madeleine")

    {:noreply, assign(socket, :game, new_game)}
  end
end
