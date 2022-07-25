defmodule GhStatsWeb.PageController do
  use GhStatsWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
