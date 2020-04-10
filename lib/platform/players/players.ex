defmodule Platform.Players do
  alias Platform.Players.Player
  alias Platform.WhiteCards

  def create(attrs) do
    white_cards = WhiteCards.random(10)

    %Player{all_white_cards: white_cards}
    |> Player.changeset(attrs, :create)
    |> Ecto.Changeset.apply_action!(:insert)
  end

  def select_white_card(%Player{} = player, white_card_id, max_picks) do
    white_card = Enum.find(player.all_white_cards, fn card -> card.id == white_card_id end)

    if Enum.find(player.selected_white_cards, fn card -> card.id == white_card_id end) do
      %{player | selected_white_cards: player.selected_white_cards -- [white_card]}
    else
      if length(player.selected_white_cards) < max_picks do
        %{player | selected_white_cards: player.selected_white_cards ++ [white_card]}
      else
        player
      end
    end
  end

  def reset_selected_white_cards(%Player{} = player) do
    if player.confirmed do
      player
    else
      %{player | selected_white_cards: []}
    end
  end

  def get_white_card_index(%Player{} = player, white_card_id) when is_integer(white_card_id) do
    index = Enum.find_index(player.selected_white_cards, fn card -> card.id == white_card_id end)
    if index do
      index + 1
    else
      nil
    end
  end
end
