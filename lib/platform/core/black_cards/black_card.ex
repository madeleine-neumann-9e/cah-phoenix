defmodule Platform.BlackCards.BlackCard do
  use Ecto.Schema
  import Ecto.Changeset

  schema "games" do
    field :question, :string
    field :picks, :integer
  end
end
