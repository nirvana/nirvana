defmodule App.Server do
  use GenServer.Behaviour

  @moduledoc """
  OTP Application that manages loaded Elixir modules. 
  This code allows you to dynamically load Elixir modules from some data source (eg: a couchbase).
  
   """
   
  def init(state) do
    { :ok, state }
  end

  @doc """
  		get: 
        - Make sure the code isn't already loaded (due to race condition)
        - Load code from the database
        - 
	"""
  def handle_call(:pop, _from, [h|stack]) do #name, status, tag, version, context
    { :reply, h, stack }
  end

  def handle_cast({ :push, new }, stack) do
    { :noreply, [new|stack] }
  end
  @doc """
      module_refresh:
        - Enumerate over all the loaded modules, spawning a process for each
        - Have each process query the database, and check if the CAS is different
        - If it is, load the new code (by calling an OTP handler)
        
   """

  def handle_info(:module_refresh, state) do
    ## BUGBUG Not Implemented, need to go thru and purge old modules.
    :erlang.send_after(:timer.seconds(10), self, :module_refresh)
    IO.puts ":module_refresh fired off."
  end

end