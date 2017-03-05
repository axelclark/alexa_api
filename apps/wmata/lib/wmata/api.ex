defmodule WMATA.API do
  @http Application.get_env(:wmata, :api)[:http_client] || HTTPoison

  def station_info(query, _owner) do
    station_code = query[:station_code] || "E03"
    platform = query[:platform] || "2"

    station_code
    |> url_for
    |> @http.get(api_key(), ssl_option())
    |> parse_response
    |> WMATA.Format.station_status(platform)
  end


  defp url_for(station_code) do
    station_code = URI.encode(station_code)
    "https://api.wmata.com/StationPrediction.svc/json/GetPrediction/#{station_code}"
  end

  defp api_key do
    [{"api_key", "4f3b58f7cca542ec97c1221da5a60fd0"}]
  end

  defp ssl_option do
    [ssl: [versions: [:"tlsv1.2"]]]
  end

  defp parse_response({:ok, %HTTPoison.Response{body: body, status_code: 200}}) do
    body
    |> Poison.decode!
    |> get_trains_for_station
  end

  defp get_trains_for_station(json) do
    json["Trains"]
  end
end
