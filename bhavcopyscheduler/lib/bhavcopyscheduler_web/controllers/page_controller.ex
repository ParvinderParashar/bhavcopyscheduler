defmodule BhavcopyschedulerWeb.PageController do
  use BhavcopyschedulerWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
