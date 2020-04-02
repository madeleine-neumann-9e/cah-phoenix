defmodule Platform.Games do
  alias Platform.Games.CurrentRound
  alias Platform.Games.Game
  alias Platform.Games.Player
  alias Platform.Cards

  def new do
    [black_card] =
      Cards.list_black_cards()
      |> Enum.take_random(1)

    %Game{
      id: :rand.uniform(10000),
      password: "secret",
      current_round: CurrentRound.new(),
      players: [],
      black_card: black_card,
      used_black_cards: [],
      used_white_cards: []
    }
  end

  def add_player(%Game{} = game, name) do
    %{game | players: game.players ++ [Player.new(name)]}
  end

  def current_player(_conn, %Game{} = game) do
    game |> Map.get(:players) |> List.first
  end

  def select_white_card(%Game{players: players} = game, %Player{} = current_player, white_card_id) do
    white_card = Enum.find(current_player.all_white_cards, fn card -> card.id == white_card_id end)

    new_players = Enum.map(players, fn player ->
      if player.id == current_player.id do
        %{player | selected_white_cards: current_player.selected_white_cards ++ [white_card]}
      else
        player
      end
    end)

    %{game | players: new_players}
  end


  def get_white_card_index(%Player{} = player, white_card) do
    index = Enum.find_index(player.selected_white_cards, fn card -> card == white_card end)
    if index do
      index + 1
    else
      nil
    end
  end
end
