defmodule WMATA.Backends.APITest do
  use ExUnit.Case, async: true

  alias WMATA.API

  describe "" do
    test "makes request, reports results, then terminates" do
      query = [station_code: "A14", platform: "2"]
      ref = make_ref()
      {:ok, pid} = API.start_link(query, ref, self(), 1)
      Process.monitor(pid)

      station_status = station_status()
      assert_receive {:results, ^ref, ^station_status}
      assert_receive {:DOWN, _ref, :process, ^pid, :normal}
    end
  end

  defp station_status() do
    "The next trains departing Cleveland Park from platform number 2 are:   Shady Gr departing in BRD minutes.  Shady Gr departing in 5 minutes.  Shady Gr departing in 10 minutes."
  end
end
