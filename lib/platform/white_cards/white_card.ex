defmodule Platform.Cards.WhiteCard do
  use Ecto.Schema
  import Ecto.Changeset

  schema "white_cards" do
    field :answer, :string
  end

  @fields ~w(id answer)a
  def changeset(user, attrs, type) when type in [:create, :update] do
    user
    |> cast(attrs, @fields)
    |> validate_required(@fields)
  end

end
