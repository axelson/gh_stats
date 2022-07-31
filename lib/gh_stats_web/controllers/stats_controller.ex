defmodule GhStatsWeb.StatsController do
  use GhStatsWeb, :controller
  alias NimbleCSV.RFC4180, as: CSV

  def stats(conn, _params) do
    rows =
      Enum.map(GhStats.fetch_stats(), fn stats ->
        [
          stats.num_prs_needs_review,
          stats.num_prs_approved_not_merged,
          stats.num_prs_open,
          stats.num_outstanding_review_requests,
          stats.inserted_at
        ]
      end)

    csv = CSV.dump_to_iodata([
      [
        "num_prs_needs_review",
        "num_prs_approved_not_merged",
        "num_prs_open",
        "num_outstanding_review_requests",
        "inserted_at"
      ]
      | rows
    ])

    text(conn, csv)
  end
end
