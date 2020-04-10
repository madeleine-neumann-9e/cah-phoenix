defmodule Platform.Players do
  alias Platform.Players.Player
  alias Platform.WhiteCards


  def create(attrs) do
    white_cards =
      WhiteCards.list()
      |> Enum.take_random(10)

    %Player{all_white_cards: white_cards}
    |> Player.changeset(attrs, :create)
    |> Ecto.Changeset.apply_action!(:insert)
  end
end
