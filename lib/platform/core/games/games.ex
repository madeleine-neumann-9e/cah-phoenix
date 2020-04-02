defmodule Platform.Games do
  alias Platform.Games.CurrentRound
  alias Platform.Games.Game
  alias Platform.Games.Player

  def new do
    %Game{
      id: :rand.uniform(10000),
      password: "secret",
      current_round: CurrentRound.new(),
      used_black_cards: [],
      used_white_cards: []
    }
  end

  def add_player(game, name) do
    %{game | players: [Player.new(name) | game.players]}
  end
end
