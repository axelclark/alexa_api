defmodule WMATATest do
  use ExUnit.Case

  defmodule TestBackend do
    def station_info([station_code: "result", platform: _], _owner) do
      "Success"
    end

    def station_info([station_code: "timeout", platform: _], owner) do
      send(owner, {:backend, self()})
      :timer.sleep(:infinity)
    end

    def station_info([station_code: "boom", platform: _], _owner) do
      raise "boom!"
    end
  end

  describe "get_station_info/3" do
    test "with backend results" do
      result = WMATA.get_station_info("result", "2", backend: TestBackend)

      assert result == "Success"
    end

    test "timeout returns no results and kills workers" do
      opts = [backend: TestBackend, timeout: 10]

      result = WMATA.get_station_info("timeout", "2", opts)

      assert result == "The request timed out."
      assert_receive {:backend, backend_pid}
      ref = Process.monitor(backend_pid)
      assert_receive {:DOWN, ^ref, :process, _proc, _reason}
      refute_received {:DOWN, _, _, _}
      refute_received :timedout
    end

    @tag :capture_log
    test "discards backend errors" do
      result =
        WMATA.get_station_info("boom", "2", backend: TestBackend)

      assert result == "There was an error with the request."
      refute_received {:DOWN, _, _, _}
      refute_received :timedout
    end
  end
end
