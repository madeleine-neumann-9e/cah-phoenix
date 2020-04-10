defmodule Platform.BlackCards do
  alias Platform.BlackCards.BlackCard

  def list do
    read_json_file()
    |> Enum.with_index(1)
    |> Enum.map(fn {card, index} -> %BlackCard{
      id: index,
      question: card["text"],
      picks: card["pick"]
    } end)
  end

  # Private functions
  @black_card_file "priv/cards/black.json"
  defp read_json_file do
    @black_card_file
    |> File.read!()
    |> Jason.decode!
  end
end
