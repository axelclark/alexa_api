defmodule WMATA do
  @backend WMATA.API

  def station_info(backend, query, owner) do
    backend.station_info(query, owner)
  end

  def get_station_info(station_code, platform, opts \\ []) do
    backend = opts[:backend] || @backend
    query = [station_code: station_code, platform: platform]
    owner = self()
    timeout = opts[:timeout] || 5000

    backend
    |> spawn_query(query, owner)
    |> handle_result(timeout)

  end

  def spawn_query(backend, query, owner) do
    Task.Supervisor.async_nolink(
      WMATA.TaskSupervisor, __MODULE__, :station_info, [backend, query, owner]
    )
  end

  def handle_result(task, timeout) do
    case Task.yield(task, timeout) || Task.shutdown(task) do
      {:ok, result} ->
        result
      {:exit, _reason} ->
        "There was an error with the request."
      nil ->
        "The request timed out."
    end
  end
end
