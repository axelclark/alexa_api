defmodule BikeShare.Backends.CapitalTest do
  use ExUnit.Case, async: true
  alias BikeShare.Capital

  describe "start_link/3" do
    test "makes request, reports results, then terminates" do
      ref = make_ref()
      {:ok, pid} = Capital.start_link(1, ref, self(), 1)
      Process.monitor(pid)

      assert_receive {:results, ^ref, "The bike dock at Eads St and 15th St S has 3 bikes and 12 empty docks."}
      assert_receive {:DOWN, _ref, :process, ^pid, :normal}
    end
  end
end
