defmodule GhStats.Repo do
  use Ecto.Repo,
    otp_app: :gh_stats,
    adapter: Ecto.Adapters.Postgres
end
