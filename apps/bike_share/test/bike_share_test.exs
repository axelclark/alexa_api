defmodule BikeShareTest do
  use ExUnit.Case

  defmodule TestBackend do
    def start_link(station_id, ref, owner, limit) do
      Task.start_link(__MODULE__, :fetch, [station_id, ref, owner, limit])
    end

    def fetch("result", ref, owner, _limit) do
      send(owner, {:results, ref, "Success"})
    end

    def fetch("none", ref, owner, _limit) do
      send(owner, {:results, ref, ""})
    end

    def fetch("timeout", _ref, owner, _limit) do
      send(owner, {:backend, self()})
      :timer.sleep(:infinity)
    end

    def fetch("boom", _ref, _owner, _limit) do
      raise "boom!"
    end
  end

  describe "get_station_info/2" do
    test "returns backend results" do
      result =
        BikeShare.get_station_info("result", backends: [TestBackend])

      assert result == "Success"
    end

    test "returns empty string with no backend results" do
      result =
        BikeShare.get_station_info("none", backends: [TestBackend])

      assert result == ""
    end

    test "with timeout, returns no results and kills workers" do
      results =
        BikeShare.get_station_info("timeout", backends: [TestBackend], timeout: 10)
        assert results == ""
        assert_receive {:backend, backend_pid}
        ref = Process.monitor(backend_pid)
        assert_receive {:DOWN, ^ref, :process, _pid, _reason}
        refute_received {:DOWN, _, _, _}
        refute_received :timedout
    end

    @tag :capture_log
    test "discards backend errors" do
      result = BikeShare.get_station_info("boom", backends: [TestBackend])

      assert result == ""
      refute_received {:DOWN, _, _, _}
      refute_received :timedout
    end
  end
end
