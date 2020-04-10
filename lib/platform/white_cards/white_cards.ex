defmodule Platform.WhiteCards do
  alias Platform.WhiteCards.WhiteCard

  def list do
    read_json_file()
    |> Enum.with_index(1)
    |> Enum.map(fn {card, index} -> create(%{
      id: index,
      answer: card
    }) end)
  end

  def create(attrs \\ %{}) do
    %WhiteCard{}
    |> WhiteCard.changeset(attrs, :create)
    |> Ecto.Changeset.apply_action!(:insert)
  end

  # Private functions
  @black_card_file "priv/cards/white.json"
  defp read_json_file do
    @black_card_file
    |> File.read!()
    |> Jason.decode!
  end
end
