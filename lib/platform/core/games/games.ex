defmodule Platform.Games do
  alias Platform.Games.CurrentRound
  alias Platform.Games.Game
  alias Platform.Games.Player

  def new do
    %Game{
      id: :rand.uniform(10000),
      password: "secret",
      current_round: CurrentRound.new(),
      players: [],
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

  def select_white_card(%Game{players: players} = game, %Player{all_white_cards: all_white_cards} = player, white_card_id) do
    white_card = Enum.find(all_white_cards, fn card -> card.id == white_card_id end)
    IO.inspect %{player | selected_white_cards: player.selected_white_cards ++ [white_card]}

    game
  end
end
