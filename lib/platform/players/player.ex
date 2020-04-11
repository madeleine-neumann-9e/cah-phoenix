defmodule Platform.Players.Player do
  use Ecto.Schema
  import Ecto.Changeset
  alias Platform.WhiteCards.WhiteCard

  @primary_key {:id, :binary_id, autogenerate: true}
  schema "players" do
    field :name, :string
    field :points, :integer, default: 0
    field :confirmed, :boolean, default: false

    embeds_many :all_white_cards, WhiteCard
    embeds_many :selected_white_cards, WhiteCard
  end

  @fields ~w(name)a
  def changeset(player, attrs, type) when type in [:create, :update] do
    player
    |> cast(attrs, @fields)
    |> generate_id()
    |> validate_required(~w(id name)a)
  end

  # Private function
  defp generate_id(changeset) do
    if get_field(changeset, :id) do
      changeset
    else
      put_change(changeset, :id, Ecto.UUID.generate())
    end
  end
end
