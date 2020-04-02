defmodule Platform.Game.Player do
  defstruct [:id, :name, :all_white_cards, :points, :reader]

  def new do
    %__MODULE__{
      id: 1,
      name: "Sascha",
      all_white_cards: [1,2,5,4],
      points: 0,
      reader: false
    }
  end
end
