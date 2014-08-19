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
  	IO.puts "Nirvana: Starting Amnesic, setting up cache of caches."
	IO.puts "DB: Connecting to Nirvana Buckets..."
	dbHash = DB.setup()
	IO.puts "DB: Completed connecting to database."

	port = 8196
	IO.puts "Nirvana: Starting Cowboy on port #{port}"
	dispatch = :cowboy_router.compile([
	           {:_, [{:_, Nirvana.TopPageHandler, [dbHash]}]}
	         ])
	{:ok, _} = :cowboy.start_http(:http, 100,
	                            [port: port],
	                            [env: [dispatch: dispatch]])
   # Start Nirvana OTP App 
	IO.puts "Starting Nirvana OTP App"
	Nirvana.Supervisor.start_link
  end
end
