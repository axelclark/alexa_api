defmodule BikeShare do
  @backends [BikeShare.Capital]

  defmodule BikeStation do
    defstruct id: nil, name: nil, bikes: nil, empty_docks: nil, latest_update: nil

    def to_struct(station) do
      %BikeStation{
        id: to_integer(station.id),
        name: to_string(station.name),
        bikes: to_integer(station.bikes),
        empty_docks: to_integer(station.empty_docks),
        latest_update: to_integer(station.latest_update)
      }
    end

    defp to_integer(char_list) do
      String.to_integer(to_string(char_list))
    end
  end

  def start_link(backend, station_id, query_ref, owner, limit) do
    backend.start_link(station_id, query_ref, owner, limit)
  end

  def get_station_info(station_id, opts \\ []) do
    limit = opts[:limit] || 10
    backends = opts[:backends] || @backends

    backends
    |> Enum.map(&spawn_query(&1, station_id, limit))
    |> await_results(opts)
  end

  def spawn_query(backend, station_id, limit) do
    query_ref = make_ref()
    opts = [backend, station_id, query_ref, self(), limit]
    {:ok, pid} = Supervisor.start_child(BikeShare.Supervisor, opts)
    monitor_ref = Process.monitor(pid)
    {pid, monitor_ref, query_ref}
  end

  defp await_results(children, opts) do
    timeout = opts[:timeout] || 5000
    timer = Process.send_after(self(), :timedout, timeout)
    results = await_result(children, "", :infinity)
    cleanup(timer)
    results
  end

  defp await_result([head|tail], acc, timeout) do
    {pid, monitor_ref, query_ref} = head

    receive do
      {:results, ^query_ref, results} ->
        Process.demonitor(monitor_ref, [:flush])
        await_result(tail, results <> acc, timeout)
      {:DOWN, ^monitor_ref, :process, ^pid, _reason} ->
        await_result(tail, acc, timeout)
      :timedout ->
        kill(pid, monitor_ref)
        await_result(tail, acc, 0)
    after
      timeout ->
        kill(pid, monitor_ref)
        await_result(tail, acc, 0)
    end
  end

  defp await_result([], acc, _) do
    acc
  end

  defp kill(pid, ref) do
    Process.demonitor(ref, [:flush])
    Process.exit(pid, :kill)
  end

  defp cleanup(timer) do
    :erlang.cancel_timer(timer)
    receive do
      :timedout -> :ok
    after
      0 -> :ok
    end
  end
end
