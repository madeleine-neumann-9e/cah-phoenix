defmodule Platform.Players.Player do
  use Ecto.Schema
  import Ecto.Changeset
  alias Platform.WhiteCards.WhiteCard

  @primary_key {:id, :binary_id, autogenerate: true}
  schema "players" do
    field :name, :string
    field :points, :integer, default: 0
    field :reader, :boolean, default: false
    field :confirmed, :boolean, default: false

    embeds_many :all_white_cards, WhiteCard
    embeds_many :selected_white_cards, WhiteCard
  end

  @fields ~w(name)a
  def changeset(user, attrs, type) when type in [:create, :update] do
    user
    |> cast(attrs, @fields)
    |> validate_required(@fields)
  end
end
