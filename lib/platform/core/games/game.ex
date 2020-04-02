defmodule Platform.Games.Game do
  defstruct [:id, :password, :black_card, :current_round, :players, :used_black_cards, :used_white_cards]
end
