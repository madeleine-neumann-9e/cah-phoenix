defmodule Platform.GameLive do
  use Phoenix.LiveView
  alias Platform.Games

  def render(assigns), do: PlatformWeb.PageView.render("_game.html", assigns)

  def mount(_params, %{}, socket) do
    game =
      Games.new()
      |> Games.add_player("Sascha")

    current_user = Games.current_player(socket, game)

    {:ok, assign(assign(socket, :game, game), :current_user, current_user)}
  end


  def handle_event("add_player", %{}, socket) do
    new_game =
      socket.assigns.game
      |> Games.add_player("Madeleine")

    {:noreply, assign(socket, :game, new_game)}
  end

  def handle_event("select_card", %{"card-id" => card_id}, socket) do
    new_game =
      socket.assigns.game
      |> Games.select_white_card(socket.assigns.current_user, String.to_integer(card_id))

    current_user = Games.current_player(socket, new_game)

    {:noreply, assign(assign(socket, :game, new_game), :current_user, current_user)}
  end
end
