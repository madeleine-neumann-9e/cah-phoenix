defmodule PlatformWeb.GameController do
  use PlatformWeb, :controller
  alias Platform.Games
  alias Platform.Games.GameServer

  def create(conn, %{"game" => game_params}) do
    game = Games.new(game_params)

    {:ok, _pid} = DynamicSupervisor.start_child(Platform.GameSupervisor, {GameServer, name: GameServer.via_tuple(game.id)})

    conn
    |> redirect(to: Routes.game_path(conn, :show, game))
  end

  def show(conn, %{"id" => id}) do
    if get_session(conn, :current_player_id) do
      conn
      |> live_render(Platform.GameLive, session: %{"game_id" => id})
    else
      conn
      |> put_session(:current_player_id, Ecto.UUID.generate())
      |> put_session(:current_player_name, Platform.Players.generate_name())
      |> live_render(Platform.GameLive, session: %{"game_id" => id})
    end
  end
end
