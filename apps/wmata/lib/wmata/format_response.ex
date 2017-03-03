defmodule WMATA.Format do
  def station_status(trains_list, platform) do
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
    "The next trains departing #{train["LocationName"]} from platform number #{platform} are: "
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
