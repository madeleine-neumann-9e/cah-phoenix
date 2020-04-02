defmodule Platform.Game.CurrentRound do
  defstruct [:black_card, :reader_user_id, :current_players]

  def new do
    %__MODULE__{
      current_players: []
    }
  end

  def get_random_black_card(current_round, _used_black_cards) do
    Map.put(current_round, :black_card, 1)
  end
end
