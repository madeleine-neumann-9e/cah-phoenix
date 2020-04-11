defmodule PlatformWeb.GameController do
  use PlatformWeb, :controller

  def show(conn, %{"id" => id}) do
    if get_session(conn, :current_player_id) do
      conn
      |> live_render(Platform.GameLive, session: %{"game_id" => id})
    else
      conn
      |> put_session(:current_player_id, Ecto.UUID.generate())
      |> put_session(:current_player_name, Platform.Players.generate_name())
      |> live_render(Platform.GameLive)
    end
  end
end
