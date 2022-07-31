defmodule GhStats.Repo.Migrations.CreateQueryResults do
  use Ecto.Migration

  def change do
    create table(:query_results, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :json, :map, null: false

      add :num_prs_needs_review, :integer, null: false
      add :num_prs_approved_not_merged, :integer, null: false
      add :num_prs_open, :integer, null: false
      add :num_outstanding_review_requests, :integer, null: false

      add :rate_limit_limit, :text, null: false
      add :rate_limit_remaining, :text, null: false
      add :rate_limit_reset, :text, null: false
      add :rate_limit_used, :text, null: false

      timestamps()
    end
  end
end
