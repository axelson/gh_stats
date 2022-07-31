defmodule GhStats.SummaryStats do
  use Ecto.Schema

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "query_results" do
    field :num_prs_needs_review, :integer
    field :num_prs_approved_not_merged, :integer
    field :num_prs_open, :integer
    field :num_outstanding_review_requests, :integer

    timestamps()
  end
end
