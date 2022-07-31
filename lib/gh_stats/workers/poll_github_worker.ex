defmodule GhStats.PollGitHubWorker do
  @moduledoc """
  Polls GitHub periodically to data on Pull Requests

  https://hexdocs.pm/oban/reliable-scheduling.html
  """

  use Oban.Worker, max_attempts: 10

  @impl Oban.Worker
  def perform(%{args: %{} = args}) do
    do_work(args)
  end

  def do_work(_) do
    GhStats.run_and_save_stats_query()
  end
end
