defmodule WMATA.Application do
  # See http://elixir-lang.org/docs/stable/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    # Define workers and child supervisors to be supervised
    children = [
      # Starts a worker by calling: SupTask.Worker.start_link(arg1, arg2, arg3)
      supervisor(Task.Supervisor, [[name: WMATA.TaskSupervisor]])
      # worker(WMATA, [], restart: :temporary),
      # supervisor(Task.Supervisor, [[name: SupTask.TaskSupervisor]])
    ]

    # See http://elixir-lang.org/docs/stable/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [
      name: WMATA.Supervisor,
      strategy: :one_for_one
    ]
    Supervisor.start_link(children, opts)
  end
end
