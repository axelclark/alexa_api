defmodule WMATA do
  use GenServer

  require Logger

  @name WM

  ## Client API

  def start_link(opts \\ []) do
    GenServer.start_link(__MODULE__, :ok, opts ++ [name: WM])
  end

  def get_station_info(station_code, platform) do
    GenServer.call(
      @name, {:station, [station_code: station_code, platform: platform]}
    )
  end

  def get_state do
    GenServer.call(@name, :get_state)
  end

  def reset_state do
    GenServer.cast(@name, :reset_state)
  end

  def stop do
    GenServer.cast(@name, :stop)
  end

  ## Server Callbacks

  def init(:ok) do
    {:ok, %{}}
  end

  def handle_call(
    {:station, [station_code: station_code, platform: platform]}, _from, state
  ) do
    case station_info_of(station_code) do
      {:ok, trains_list} ->
        new_state = update_state(state, station_code)
        {:reply, format_station_status(trains_list, platform), new_state}
      _ ->
        {:reply, :error, state}
    end
  end

  def handle_call(:get_state, _from, state) do
    {:reply, state, state}
  end

  def handle_cast(:reset_state, _state) do
    {:noreply, %{}}
  end

  def handle_cast(:stop, state) do
    {:stop, :normal, state}
  end

  def terminate(reason, state) do
    IO.puts "server terminated because of #{inspect reason}"
    :ok
  end

  def handle_info(msg, state) do
    IO.puts "received #{inspect msg}"
    {:noreply, state}
  end

  ## Helper Functions
  def station_info_of(station_code) do
    url_for(station_code)
    |> HTTPoison.get(api_key(), ssl_option())
    |> parse_response
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
    try do
      train_list = json["Trains"]
      {:ok, train_list}
    rescue
      _ -> :error
    end
  end

  defp api_key do
    [{"api_key", "4f3b58f7cca542ec97c1221da5a60fd0"}]
  end

  defp ssl_option do
    [ssl: [versions: [:"tlsv1.2"]]]
  end

  defp update_state(old_state, station) do
    case Map.has_key?(old_state, station) do
      true ->
        Map.update!(old_state, station, &(&1 + 1))
      false ->
        Map.put_new(old_state, station, 1)
    end
  end

  defp format_station_status(trains_list, platform) do
    station_info = format_station_info(trains_list, platform)
    trains_info = format_trains_info(trains_list, platform)

    station_info <> trains_info
  end

  defp format_station_info(trains_list, platform) do
    trains_list
    |> List.first
    |> station_info(platform)
  end

  defp station_info(train, platform) do
    "The next trains departing #{train["LocationName"]} from platform #{platform} are: "
  end

  def format_trains_info(trains_list, platform) do
    trains_list
    |> Enum.filter(&(&1["Group"] == platform))
    |> Enum.reduce("", &(format_train_status/2))
  end

  def format_train_status(train, prev_train) do
    prev_train <> "  " <>
      "#{train["Destination"]} departing in #{train["Min"]} minutes."
  end
end
