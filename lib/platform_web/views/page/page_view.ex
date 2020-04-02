defmodule PlatformWeb.PageView do
  use PlatformWeb, :view

  def replace_placeholder(text) do
    text |> String.replace("_", "<h1>.....</h1>")
  end
end
