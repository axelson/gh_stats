defmodule GhStats.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    Ecto.DevLogger.install(GhStats.Repo)

    children = [
      GhStats.Repo,
      {Oban, Application.fetch_env!(:gh_stats, Oban)},
      GhStatsWeb.Telemetry,
      {Phoenix.PubSub, name: GhStats.PubSub},
      GhStatsWeb.Endpoint,
      # This should be last so that systemd knows when the full application is ready
      GhStats.SystemdReadyWorker
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
