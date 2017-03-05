defmodule WMATATest do
  use ExUnit.Case

  defmodule TestBackend do
    def start_link(query, ref, owner, limit) do
      Task.start_link(__MODULE__, :station_info, [query, ref, owner, limit])
    end

    def station_info(
      [station_code: "result", platform: _], ref, owner, _limit
    ) do
      send(owner, {:results, ref, "Success"})
    end

    def station_info(
      [station_code: "timeout", platform: _], ref, owner, _limit
    ) do
      send(owner, {:backend, self()})
      :timer.sleep(:infinity)
    end

    def station_info(
      [station_code: "boom", platform: _], ref, owner, _limit
    ) do
      raise "boom!"
    end
  end

  describe "get_station_info/3" do
    test "with backend results" do
      result = WMATA.get_station_info("result", "2", backends: [TestBackend])

      assert result == "Success"
    end

    test "timeout returns no results and kills workers" do
      opts = [backends: [TestBackend], timeout: 10]

      result = WMATA.get_station_info("timeout", "2", opts)

      assert result == ""
      assert_receive {:backend, backend_pid}
      ref = Process.monitor(backend_pid)
      assert_receive {:DOWN, ^ref, :process, _pid, _reason}
      refute_received {:DOWN, _, _, _}
      refute_received :timedout
    end

    @tag :capture_log
    test "discards backend errors" do
      result =
        WMATA.get_station_info("boom", "2", backends: [TestBackend])

      assert result == ""
      refute_received {:DOWN, _, _, _}
      refute_received :timedout
    end
  end
end
