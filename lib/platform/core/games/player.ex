defmodule Platform.Games.Player do
  use Ecto.Schema

  alias Platform.WhiteCards

  @primary_key {:id, :binary_id, autogenerate: true}
  schema "players" do
    field :name, :string
    field :all_white_cards, :string
    field :points, :integer
    field :reader, :boolean
    field :selected_white_cards, :string
    field :confirmed, :boolean
  end

  def new(name) do
    white_cards =
      WhiteCards.list()
      |> Enum.take_random(10)

    %__MODULE__{
      # id: :rand.uniform(10_000),
      name: name,
      all_white_cards: white_cards,
      points: 0,
      confirmed: false,
      selected_white_cards: []
    }
  end
end
