defmodule WMATA do
  require Logger

  def get_station_info(station_code, platform) do
    spawn_query(station_code, platform)
  end

  def spawn_query(station_code, platform) do
    WMATA.TaskSupervisor
    |> Task.Supervisor.async(__MODULE__, :station_info, [station_code, platform])
    |> Task.await()
  end

  def station_info(station_code, platform) do
    url_for(station_code)
    |> HTTPoison.get(api_key(), ssl_option())
    |> parse_response
    |> WMATA.Format.station_status(platform)
  end

  defp url_for(station_code) do
    station_code = URI.encode(station_code)
    "https://api.wmata.com/StationPrediction.svc/json/GetPrediction/#{station_code}"
  end

  defp parse_response({:ok, %HTTPoison.Response{body: body, status_code: 200}}) do
    body
    |> Poison.decode!
    |> get_trains_for_station
  end

  defp parse_response(_) do
    :error
  end

  defp get_trains_for_station(json) do
    json["Trains"]
  end

  defp api_key do
    [{"api_key", "4f3b58f7cca542ec97c1221da5a60fd0"}]
  end

  defp ssl_option do
    [ssl: [versions: [:"tlsv1.2"]]]
  end
end
