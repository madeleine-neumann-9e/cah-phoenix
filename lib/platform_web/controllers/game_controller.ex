defmodule PlatformWeb.GameController do
  use PlatformWeb, :controller

  def show(conn, _params) do
    if get_session(conn, :current_player_id) do
      conn
      |> live_render(Platform.GameLive)
    else
      conn
      |> put_session(:current_player_id, Ecto.UUID.generate())
      |> put_session(:current_player_name, Platform.Players.generate_name())
      |> live_render(Platform.GameLive)
    end
  end
end
