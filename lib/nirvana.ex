defmodule Nirvana do
  use Application.Behaviour
  @moduledoc """
   The Nirvana Application

   ## To run as daemon:

       $ mix run --no-halt
  ## To run interactively:

      $ iex -S mix

   """
   
  @doc "Start- launches cowboy, other initialization, sets up supervisor"

  def start(_type, _args) do
	# Setup Couchie
	IO.puts "Starting Couchie"
	Couchie.open(:cb)

	# Setup Cowboy
	IO.puts "Starting Cowboy"
	dispatch = :cowboy_router.compile([
	           {:_, [{"/", Nirvana.TopPageHandler, []}]}
	         ])
	{:ok, _} = :cowboy.start_http(:http, 100,
	                            [port: 8196],
	                            [env: [dispatch: dispatch]])
   # Start Nirvana OTP App 
	IO.puts "Starting Nirvana"
	Nirvana.Supervisor.start_link
  end
end
