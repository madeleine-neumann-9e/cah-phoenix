defmodule Platform.Game.Room do
  defstruct [:id, :password, :current_round, :players, :used_black_cards, :used_white_cards]

  def new do
    %__MODULE__{
      id: :rand.uniform(10000),
      password: "secret"
    }
  end
end
