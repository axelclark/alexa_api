defmodule WMATA.Test.HTTPClient do
  @trains_json File.read!("test/fixtures/trains.json")

  def get(url, _, _) do
    url = to_string(url)

    cond do
      String.contains?(url, "StationPrediction") ->
        {:ok, %HTTPoison.Response{body: @trains_json, status_code: 200}}
      true ->
        {:ok, %HTTPoison.Response{body: {}, status_code: 200}}
    end
  end
end
