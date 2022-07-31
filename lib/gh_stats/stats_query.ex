defmodule GhStats.StatsQuery do
  require Logger

  def run_query do
    query = File.read!(Path.join([__DIR__, "queries/stats_query.graphql"]))
    GhStats.run_query(query)
  end

  def response_to_changeset(%Neuron.Response{} = response) do
    attrs = %{
      json: response.body,
      # Calculations
      num_prs_needs_review: num_prs_needs_review(response),
      num_prs_approved_not_merged: num_prs_approved_not_merged(response),
      num_prs_open: num_prs_open(response),
      num_outstanding_review_requests: num_outstanding_review_requests(response),
      # Rate limits
      rate_limit_limit: get_header(response, "X-RateLimit-Limit"),
      rate_limit_remaining: get_header(response, "X-RateLimit-Remaining"),
      rate_limit_reset: get_header(response, "X-RateLimit-Reset"),
      rate_limit_used: get_header(response, "X-RateLimit-Used")
    }

    GhStats.QueryResult.changeset(%GhStats.QueryResult{}, attrs)
  end

  def num_prs_needs_review(%Neuron.Response{} = response) do
    pull_requests(response)
    |> Enum.count(fn pull_request ->
      pull_request["isDraft"] == false &&
        pull_request["reviewDecision"] == "REVIEW_REQUIRED" &&
        !pull_request["merged"]
    end)
  end

  def num_prs_approved_not_merged(%Neuron.Response{} = response) do
    pull_requests(response)
    |> Enum.count(fn pull_request ->
      pull_request["reviewDecision"] == "APPROVED" &&
        !pull_request["merged"]
    end)
  end

  def num_prs_open(%Neuron.Response{} = response) do
    get_in(response.body, ["data", "repository", "pullRequests", "totalCount"])
    |> tap(fn total ->
      if total >= 100 do
        Logger.warn("More PRs open than can be fetched in a single pagination")
      end
    end)
  end

  def num_outstanding_review_requests(%Neuron.Response{} = response) do
    pull_requests(response)
    |> Enum.reduce(0, fn pull_request, acc ->
      if pull_request["isDraft"] == true do
        acc
      else
        num_review_requests = length(pull_request["reviewRequests"]["nodes"])
        acc + num_review_requests
      end
    end)
  end

  def pull_requests(%Neuron.Response{} = response) do
    get_in(response.body, ["data", "repository", "pullRequests", "edges", Access.all(), "node"])
  end

  defp get_header(%Neuron.Response{headers: headers}, header) do
    :proplists.get_value(header, headers)
  end
end
