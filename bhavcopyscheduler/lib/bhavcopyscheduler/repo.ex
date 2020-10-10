defmodule Bhavcopyscheduler.Repo do
  use Ecto.Repo,
    otp_app: :bhavcopyscheduler,
    adapter: Ecto.Adapters.Postgres
end
