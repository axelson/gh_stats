defmodule GhStats.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      GhStats.Repo,
      # Start the Telemetry supervisor
      GhStatsWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: GhStats.PubSub},
      # Start the Endpoint (http/https)
      GhStatsWeb.Endpoint
      # Start a worker by calling: GhStats.Worker.start_link(arg)
      # {GhStats.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: GhStats.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    GhStatsWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
