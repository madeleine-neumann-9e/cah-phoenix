defmodule Playform.GameServer do
  use GenServer

  alias Platform.Games

  def start_link(options) do
    game = Games.new()
    GenServer.start_link(__MODULE__, game, options)
  end

  @impl true
  def init(game) do
    {:ok, game}
  end

  @impl true
  def handle_call(:game, _from, game) do
    {:reply, game, game}
  end

  @impl true
  def handle_cast({:add_player, name}, game) do
    {:noreply, Games.add_player(game, name)}
  end
end
