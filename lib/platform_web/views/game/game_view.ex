defmodule PlatformWeb.GameView do
  use PlatformWeb, :view

  alias Platform.Games
  alias Platform.Players

  def replace_placeholder(text) do
    text |> String.replace("_", ~s(<span style="color: red">[...]</span>))
  end
end
