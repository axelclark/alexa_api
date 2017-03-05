defmodule WMATA do
  @backend WMATA.API

  def station_info(backend, query, owner) do
    backend.station_info(query, owner)
  end

  def get_station_info(station_code, platform, opts \\ []) do
    backend = opts[:backend] || @backend
    query = [station_code: station_code, platform: platform]
    owner = self()

    backend
    |> spawn_query(query, owner)
    |> await_results(opts)
  end

  def spawn_query(backend, query, owner) do
    Task.Supervisor.async_nolink(
      WMATA.TaskSupervisor, __MODULE__, :station_info, [backend, query, owner]
    )
  end

  def await_results(task, opts) do
    timeout = opts[:timeout] || 5000
    await_result(task, timeout)
  end

  def await_result(%{ref: ref, pid: pid, owner: _owner}, timeout \\ 5000) do
    receive do
      {^ref, reply} ->
        Process.demonitor(ref, [:flush])
        reply
      {:DOWN, ^ref, _, _proc, _reason} ->
        "There was an error with the request."
    after
      timeout ->
        kill(pid, ref)
        "The request timed out."
    end
  end

  defp kill(pid, ref) do
    Process.demonitor(ref, [:flush])
    Process.exit(pid, :kill)
  end
end
