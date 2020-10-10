defmodule Bhavcopyscheduler.CSVUtility do
  @moduledoc """
    Module fetching latest bhav copy file and cache it
  """

  require Logger

  def fetch_csv_file() do
    date = DateTime.utc_now

    date.day
    |> get_url(date.year)
    |> get_data(date)

  end

  def get_data(url, date) do
    case HTTPoison.get(url) do
      {:ok, %{status_code: 200, body: body}} ->
        response = Poison.decode!(body)
        Cache.set("data:#{date.day}", response, ttl: 1000)
        Logger.info("csv data pulled successfully")

      {:ok, %{status_code: 404}} ->
        (date.day - 1)
        |> get_url(date.year)
        |> get_data(date)

      {:error, %{reason: reason}} ->
        Logger.error("csv fetching failed due to #{reason}")
    end
  end

  def get_url(day, year) do
    url = "https://www1.nseindia.com/content/historical/EQUITIES/#{year}/OCT/cm#{day}OCT#{year}bhav.csv.zip"
  end

end
