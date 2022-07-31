defmodule GhStats.SystemdReadyWorker do
  use GenServer

  def init(_opts) do
    :systemd.notify(:ready)
    {:ok, []}
  end

  def start_link(opts \\ []) do
    GenServer.start_link(__MODULE__, opts, name: __MODULE__)
  end
end
