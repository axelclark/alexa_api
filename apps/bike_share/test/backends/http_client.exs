defmodule BikeShare.Test.HTTPClient do
  @bike_share_xml File.read!("test/fixtures/bike_stations.xml")
  def request(url) do
    url = to_string(url)
    cond do
      String.contains?(url, "capitalbikeshare") -> {:ok, {[], [], @bike_share_xml}}
      true -> {:ok, {[], [], "<stations></stations>"}}
    end
  end
end
