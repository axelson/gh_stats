defmodule GhStats do
  def demo do
    Neuron.Config.set(url: "https://api.github.com/graphql")
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

  defp run_query(query) do
    Neuron.query(
      query,
      %{},
      headers: [authorization: "Bearer #{gh_token()}"]
    )
  end

  defp gh_token, do: Application.fetch_env!(:gh_stats, :gh_token)
end
