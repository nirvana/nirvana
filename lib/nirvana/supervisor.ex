defmodule Nirvana.Supervisor do
  use Supervisor.Behaviour
  @moduledoc """
   Nirvana Application Supervisor

   ## To run as daemon:

       $ mix run --no-halt
  ## To run interactively:

      $ iex -S mix

   """
   
  @doc "supervisor.start_link"

  def start_link do
    :supervisor.start_link(__MODULE__, [])
  end
  
  #  When we have OTP servers we want to start, add them like here:
  #    children = [ worker(Stacker.Server, [stack]) ]

  @doc "no children defined, is that ok?"
  def init([]) do
    children = []
    supervise children, strategy: :one_for_one
  end
end
