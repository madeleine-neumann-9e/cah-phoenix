defmodule PlatformWeb.GameController do
  use PlatformWeb, :controller
  alias Platform.Games

  def index(conn, _params) do
    render(conn, "index.html")
  end

  #def create(conn, %{"game" => game_params}) do
  #end

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
