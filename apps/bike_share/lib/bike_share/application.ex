defmodule BikeShare.Application do
  # See http://elixir-lang.org/docs/stable/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    # Define workers and child supervisors to be supervised
    children = [
      # Starts a worker by calling: BikeShare.Worker.start_link(arg1, arg2, arg3)
      worker(BikeShare, [], restart: :temporary),
    ]

    # See http://elixir-lang.org/docs/stable/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [
      strategy: :simple_one_for_one,
      name: BikeShare.Supervisor
    ]

    Supervisor.start_link(children, opts)
  end
end
