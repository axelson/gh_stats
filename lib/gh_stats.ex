defmodule GhStats do
  alias GhStats.StatsQuery

  def run do
    {:ok, result} = demo_query()
    changeset = GhStats.QueryResult.changeset(%GhStats.QueryResult{}, %{json: result.body})
    GhStats.Repo.insert(changeset)
  end

  def run_stats_query do
    query = File.read!(Path.join([__DIR__, "gh_stats/queries/stats_query.graphql"]))
    run_query(query)
  end

  def run_and_save_stats_query do
    {:ok, response} = StatsQuery.run_query()
    changeset = StatsQuery.response_to_changeset(response)
    GhStats.Repo.insert(changeset)
  end

  def demo_query do
    query = File.read!(Path.join([__DIR__, "gh_stats/pull_request_query.graphql"]))
    run_query(query)
  end

  # https://docs.github.com/en/graphql/guides/forming-calls-with-graphql#the-graphql-endpoint
  def demo2 do
    Neuron.Config.set(url: "https://api.github.com/graphql")

    Neuron.query(
      """
      query {
        viewer {
          login
        }
      }
      """,
      %{},
      headers: [authorization: "Bearer #{gh_token()}"]
    )
  end

  def run_query(query) do
    Neuron.Config.set(url: "https://api.github.com/graphql")

    Neuron.query(
      query,
      %{},
      headers: [authorization: "Bearer #{gh_token()}"]
    )
  end

  defp gh_token, do: Application.fetch_env!(:gh_stats, :gh_token)
end
