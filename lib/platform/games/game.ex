defmodule Platform.Games.Game do
  use Ecto.Schema
  import Ecto.Changeset

  schema "games" do
    field :password, :string
    field :black_card, :string
    field :players, :string
    field :used_black_cards, :string
    field :used_white_cards, :string
  end
end
