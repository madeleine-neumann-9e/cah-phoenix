defmodule Platform.Games.Game do
  use Ecto.Schema
  import Ecto.Changeset

  alias Platform.Players.Player
  alias Platform.BlackCards.BlackCard

  @primary_key {:id, :binary_id, autogenerate: true}
  schema "games" do
    belongs_to :reader_player, Player
    belongs_to :black_card, BlackCard
    embeds_many :players, Player
  end
end
