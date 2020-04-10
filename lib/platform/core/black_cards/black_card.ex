defmodule Platform.BlackCards.BlackCard do
  use Ecto.Schema
  import Ecto.Changeset

  schema "games" do
    field :question, :string
    field :picks, :integer
  end

  @fields ~w(id question picks)a
  def changeset(user, attrs, type) when type in [:create, :update] do
    user
    |> cast(attrs, @fields)
    |> validate_required(@fields)
  end
end
