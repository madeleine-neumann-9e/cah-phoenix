defmodule Platform.Games do
  alias Platform.BlackCards
  alias Platform.Games.Game
  alias Platform.Players
  alias Platform.Players.Player

  def new do
    %Game{}
    |> Game.changeset(%{}, :create)
    |> Ecto.Changeset.apply_action!(:insert)
    |> start_round()
  end

  def add_player(%Game{} = game, name) do
    %{game |
      players: game.players ++ [Players.create(%{name: name})]
    }
  end

  def start_round(%Game{} = game) do
    %{game |
      black_card: BlackCards.random_card()
    }
  end

  def current_player(_conn, %Game{} = game) do
    game |> Map.get(:players) |> List.first
  end

  def select_white_card(%Game{} = game, %Player{} = player, white_card_id) when is_integer(white_card_id) do
    player
    |> Players.select_white_card(white_card_id, game.black_card.picks)
    |> update_player(game)
  end

  def show_reset_button?(%Game{} = _game, %Player{} = player) do
    length(player.selected_white_cards) > 0 && !player.confirmed
  end

  def show_confirm_button?(%Game{black_card: black_card}, %Player{selected_white_cards: selected_white_cards}) do
    length(selected_white_cards) == black_card.picks
  end

  def player_reset_white_cards(%Game{} = game, %Player{} = player) do
    player
    |> Players.reset_selected_white_cards()
    |> update_player(game)
  end

  # Private functions
  defp update_player(%Player{} = updated_player, %Game{} = game) do
    new_players =
      Enum.map(game.players, fn player ->
        if player.id == updated_player.id do
          updated_player
        else
          player
        end
      end)
    %{game | players: new_players}
  end
end
