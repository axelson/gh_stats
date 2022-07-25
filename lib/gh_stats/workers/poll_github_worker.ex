defmodule GhStats.PollGitHubWorker do
  @moduledoc """
  Polls GitHub periodically to data on Pull Requests

  https://hexdocs.pm/oban/reliable-scheduling.html
  """

  use Oban.Worker, max_attempts: 10

  # @one_hour 60 * 60
  # @one_hour 3_000

  # def perform(%{args: %{} = args, attempt: 1}) do
  #   args
  #   |> new(schedule_in: @one_hour)
  #   |> Oban.insert!()

  #   do_work(args)
  # end

  @impl Oban.Worker
  def perform(%{args: %{} = args}) do
    do_work(args)
  end

  def do_work(_) do
    IO.puts("Poll GitHub!")
  end
end
