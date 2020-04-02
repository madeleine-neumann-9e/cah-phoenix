defmodule Platform.Games.Player do
  defstruct [:id, :name, :all_white_cards, :points, :reader]

  def new(name) do
    %__MODULE__{
      id: :rand.uniform(10000),
      name: name,
      all_white_cards: [],
      points: 0
    }
  end
end
