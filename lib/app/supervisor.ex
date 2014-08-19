defmodule App.Supervisor do
  use Supervisor.Behaviour

  # A convenience to start the supervisor
  def start_link(state) do
    :supervisor.start_link(__MODULE__, state)
  end

  # The callback invoked when the supervisor starts
  def init(state) do
    children = [ worker(App.Server, [state]) ]
    supervise children, strategy: :one_for_one
  end
end