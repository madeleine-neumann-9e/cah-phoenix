defmodule Platform.GameLive do
  use Phoenix.LiveView
  alias Platform.Games
  alias Platform.Games.GameServer

  def render(assigns), do: PlatformWeb.GameView.render("show.html", assigns)

  def mount(_params, %{"game_id" => game_id, "current_player_id" => current_player_id, "current_player_name" => current_player_name}, socket) do
    players_visible = false

    GameServer.add_player(game_id, current_player_id, current_player_name)

    {:ok,
      socket
      |> assign(%{players_visible: players_visible})
      |> assign_game(game_id)
    }
  end

  def handle_event("start_round", %{}, socket) do
    new_game =
      socket.assigns.game
      |> Games.start_round()

    {:noreply, assign(socket, %{game: new_game})}
  end

  def handle_event("toggle_players_visible", %{}, socket) do
    players_visible = !socket.assigns.players_visible

    {:noreply, assign(socket, %{players_visible: players_visible})}
  end

  def handle_event("reset_white_cards", %{}, socket) do
    new_game =
      socket.assigns.game
      |> Games.player_reset_white_cards(socket.assigns.current_player)

    {:noreply, assign(socket, %{game: new_game})}
  end

  def handle_event("select_card", %{"card-id" => card_id}, socket) do
    new_game =
      socket.assigns.game
      |> Games.select_white_card(socket.assigns.current_player, String.to_integer(card_id))

    current_player = Games.current_player(socket, new_game)

    {:noreply, assign(socket, %{game: new_game, current_player: current_player})}
  end


  defp assign_game(socket, game_id) do
    socket
    |> assign(game_id: game_id)
    |> assign_game()
  end

  defp assign_game(%{assigns: %{game_id: game_id}} = socket) do
    game = GameServer.get_game(game_id)
    IO.inspect game
    assign(socket, game: game)
  end
end
