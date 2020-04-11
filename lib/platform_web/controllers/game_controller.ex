defmodule PlatformWeb.GameController do
  use PlatformWeb, :controller

  def show(conn, _params) do
    live_render(conn, Platform.GameLive)
  end
end
