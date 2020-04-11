defmodule Platform.BlackCards do
  alias Platform.BlackCards.BlackCard

  def list do
    read_json_file()
    |> Enum.with_index(1)
    |> Enum.map(fn {card, index} -> create(%{
      id: index,
      question: card["text"],
      picks: card["pick"]
    }) end)
  end

  def random_card do
    list()
    |> Enum.take_random(1)
    |> List.first()
  end

  def create(attrs \\ %{}) do
    %BlackCard{}
    |> BlackCard.changeset(attrs, :create)
    |> Ecto.Changeset.apply_action!(:insert)
  end

  # Private functions
  @black_card_file "priv/cards/black.json"
  defp read_json_file do
    @black_card_file
    |> File.read!()
    |> Jason.decode!
  end
end
