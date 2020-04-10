defmodule Platform.Games.Player do
  use Ecto.Schema

  alias Platform.Cards

  schema "players" do
    field :name, :string
    field :all_white_cards, :string
    field :points, :string
    field :reader, :string
    field :selected_white_cards, :string
    field :confirmed, :boolean
  end

  def new(name) do
    white_cards =
      Cards.list_white_cards()
      |> Enum.take_random(10)

    %__MODULE__{
      id: :rand.uniform(10_000),
      name: name,
      all_white_cards: white_cards,
      points: 0,
      confirmed: false,
      selected_white_cards: []
    }
  end
end
