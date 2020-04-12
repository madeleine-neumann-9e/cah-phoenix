defmodule Platform.Games.GameServer do
  use GenServer

  alias Platform.Games

  def start(name) do
    DynamicSupervisor.start_child(Platform.GameSupervisor, {Game, name: via_tuple(name)})
  end

  def start_link(options) do
    game = Games.new()
    GenServer.start_link(__MODULE__, game, options)
  end

  def get_game(game_id) do
    GenServer.call(via_tuple(game_id), :game)
  end

  def update_game(game_id, game) do
    GenServer.cast(via_tuple(game_id), {:update, game})
  end

  def add_player(game_id, id, name) do
    GenServer.cast(via_tuple(game_id), {:add_player, id, name})
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
  def handle_cast({:add_player, id, name}, game) do
    {:noreply, Games.add_player(game, id, name)}
  end

  @impl true
  def handle_cast({:update, updated_game}, game) do
    {:noreply, updated_game}
  end

  # Private functions
  def via_tuple(name) do
    {:via, Registry, {Platform.GameRegistry, name}}
  end
end
