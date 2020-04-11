defmodule Platform.Games.Game do
  use Ecto.Schema
  import Ecto.Changeset

  alias Platform.Players.Player
  alias Platform.BlackCards.BlackCard

  @primary_key {:id, :binary_id, autogenerate: true}
  schema "games" do
    field :private, :boolean, default: false

    belongs_to :reader_player, Player
    belongs_to :black_card, BlackCard
    embeds_many :players, Player
  end

  @fields ~w(private reader_player_id)a
  def changeset(game, attrs, type) when type in [:create, :update] do
    game
    |> cast(attrs, @fields)
    |> generate_id()
    |> validate_required(~w(id)a)
  end

  # Private functions
  defp generate_id(changeset) do
    if get_field(changeset, :id) do
      changeset
    else
      put_change(changeset, :id, Ecto.UUID.generate())
    end
  end
end
