defmodule GhStats do
  # https://docs.github.com/en/graphql/guides/forming-calls-with-graphql#the-graphql-endpoint
  def demo do
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

  defp gh_token, do: Application.fetch_env!(:gh_stats, :gh_token)
end
