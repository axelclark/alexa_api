defmodule WMATA.Backends.APITest do
  use ExUnit.Case, async: true

  alias WMATA.API

  describe "station_info/2" do
    test "returns station status" do
      query = [station_code: "A14", platform: "2"]
      result = API.station_info(query, [])

      assert result == station_status()
    end
  end

  defp station_status() do
    "The next trains departing Cleveland Park from platform number 2 are:   Shady Gr departing in BRD minutes.  Shady Gr departing in 5 minutes.  Shady Gr departing in 10 minutes."
  end
end
