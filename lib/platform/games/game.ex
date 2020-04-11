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

  @fields ~w()a
  def changeset(user, attrs, type) when type in [:create, :update] do
    user
    |> cast(attrs, @fields)
    |> validate_required(@fields)
    |> generate_id()
  end

  # Private functions
  defp generate_id(changeset) do
    changeset
    |> put_change(:id, Ecto.UUID.generate())
  end
end
