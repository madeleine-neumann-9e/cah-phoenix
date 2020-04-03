defmodule PlatformWeb.PageView do
  use PlatformWeb, :view

  alias Platform.Games

  def replace_placeholder(text) do
    text |> String.replace("_", ~s(<span style="color: red">[...]</span>))
  end
end
