defmodule BikeShare.Capital do
  import SweetXml
  alias BikeShare.BikeStation

  def start_link(station_id, query_ref, owner, limit) do
    Task.start_link(__MODULE__, :fetch, [station_id, query_ref, owner, limit])
  end

  def fetch(station_id, query_ref, owner, _limit) do
    response = fetch_xml()

    response
    |> parse_xml()
    |> get_station(station_id)
    |> format_station
    |> send_results(query_ref, owner)
  end

  def fetch_xml() do
    url = "https://feeds.capitalbikeshare.com/stations/stations.xml"

    {:ok, {_, _, body}} = :httpc.request(String.to_char_list(url))
    body
  end

  def parse_xml(body) do
    body
    |> xmap(
         stations: [
           ~x"//stations/station"l,
           id: ~x"./id/text()",
           name: ~x"./name/text()",
           bikes: ~x"./nbBikes/text()",
           empty_docks: ~x"./nbEmptyDocks/text()",
           latest_update: ~x"./latestUpdateTime/text()"
         ]
       )
    |> stations_to_struct
  end

  defp stations_to_struct(%{stations: stations}) do
    Enum.map(stations, &(BikeStation.to_struct/1))
  end

  defp get_station(stations, id) do
    Enum.find(stations, &(&1.id == id))
  end

  defp format_station(station) do
    "The bike dock at #{station.name} has #{to_string(station.bikes)} bikes and #{to_string(station.empty_docks)} empty docks."
  end

  defp send_results(nil, query_ref, owner) do
    send(owner, {:results, query_ref, []})
  end

  defp send_results(station, query_ref, owner) do
    send(owner, {:results, query_ref, station})
  end
end
