defmodule GhStats.QueryResult do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "query_results" do
    field :json, :map

    field :num_prs_needs_review, :integer
    field :num_prs_approved_not_merged, :integer
    field :num_prs_open, :integer
    field :num_outstanding_review_requests, :integer

    field :rate_limit_limit, :string
    field :rate_limit_remaining, :string
    field :rate_limit_reset, :string
    field :rate_limit_used, :string

    timestamps()
  end

  @doc false
  def changeset(query_result, attrs) do
    query_result
    |> cast(attrs, [
      :json,
      :num_prs_needs_review,
      :num_prs_approved_not_merged,
      :num_prs_open,
      :num_outstanding_review_requests,
      :rate_limit_limit,
      :rate_limit_remaining,
      :rate_limit_reset,
      :rate_limit_used
    ])
    |> validate_required([:json])
  end
end
