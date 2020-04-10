defmodule Platform.Games.Game do
  use Ecto.Schema
  import Ecto.Changeset

  schema "games" do
    field :black_card, :string
    field :players, :string
  end
end
