defmodule PlatformWeb.GameView do
  use PlatformWeb, :view

  alias Platform.Games
  alias Platform.Players

  def replace_placeholder(black_card, []) do
    black_card |> String.replace("_", ~s(<span style="color: red">[...]</span>))
  end
  def replace_placeholder(text, white_cards) do
    if String.contains?(text, "_") do
      text |> String.replace("_", ~s(<span style="color: red">[...]</span>))
    else
      white_card = white_cards |> List.first
      text <> ~s(<span style="color: red">#{white_card.answer}</span>)
    end
  end
end
