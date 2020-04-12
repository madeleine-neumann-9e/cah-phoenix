defmodule Platform.Games do
  alias Platform.BlackCards
  alias Platform.Games.Game
  alias Platform.Players
  alias Platform.Players.Player

  def new(attrs \\ %{}) do
    %Game{}
    |> Game.changeset(attrs, :create)
    |> Ecto.Changeset.apply_action!(:insert)
    |> start_round()
  end

  def add_player(%Game{} = game, id, name) do
    if find_player_by_id(game, id) do
      game
    else
      %{game | players: game.players ++ [Players.create(%{id: id, name: name})]}
    end
  end

  def change(attrs \\ %{}) do
    Game.changeset(%Game{}, attrs, :create)
  end

  def start_round(%Game{} = game) do
    %{
      game
      | black_card: BlackCards.random_card(),
        reader_player_id: find_next_reader_player_id(game),
        players: Enum.map(game.players, fn player -> Players.reset_for_new_round(player) end)
    }
  end

  def find_player_by_id(%Game{} = game, player_id) do
    Enum.find(game.players, fn player -> player.id == player_id end)
  end

  def current_player(%Game{} = game, current_player_id) do
    find_player_by_id(game, current_player_id)
  end

  def select_white_card(%Game{} = game, player_id, white_card_id)
      when is_integer(white_card_id) do
    game
    |> find_player_by_id(player_id)
    |> Players.select_white_card(white_card_id, game.black_card.picks)
    |> update_player(game)
  end

  def show_reset_button?(%Game{} = _game, %Player{} = player) do
    length(player.selected_white_cards) > 0 && !player.confirmed
  end

  def show_confirm_button?(%Game{black_card: black_card}, %Player{
        selected_white_cards: selected_white_cards
      }) do
    length(selected_white_cards) == black_card.picks
  end

  def player_reset_white_cards(%Game{} = game, %Player{} = player) do
    player
    |> Players.reset_selected_white_cards()
    |> update_player(game)
  end

  def player_is_reader?(%Game{reader_player_id: reader_player_id}, %Player{id: player_id}) do
    reader_player_id == player_id
  end

  # Private functions
  defp find_next_reader_player_id(%Game{players: []}) do
    nil
  end

  defp find_next_reader_player_id(%Game{players: players}) do
    players |> List.first() |> Map.get(:id)
  end

  defp update_player(%Player{} = updated_player, %Game{} = game) do
    new_players =
      Enum.map(game.players, fn player ->
        if player.id == updated_player.id do
          updated_player
        else
          player
        end
      end)

    %{game | players: new_players}
  end
end
