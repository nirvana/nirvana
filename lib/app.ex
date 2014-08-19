
## AppState is merely a record with a hashdict that tracks current 
## modules that are loaded.  This becomes the state managed by the OTP App
defrecord AppState, modules: nil

## AppModule represents a given module loaded into beam from the 
## database.  
# 		Cookie is the magic cookie used by elixir to call the module, 
#			something like Elixir.Foo.Bar
#		cas is the cas value returned by couchbase, which we check to
#			see if the current code in the database has changed from the
#			code already loaded in the vm
#		path is the key in the database where the code is stored.
defrecord AppModule, cookie: nil, cas: nil, path: nil   #, data: nil  #punting on storing data. Modules are just code now.

defmodule App do
	use Application.Behaviour

	def start(_type, mods) do
	## We're ignoring the passed in mods, and instead we're going to 
	## create a HashDict here.
		modamo = HashDict.new
		state = AppState.new(modules: modamo)
		App.Supervisor.start_link(state)
	## Start the timer so that the code refresher will run.
	:erlang.send_after(:timer.seconds(10), self, :module_refresh)
	end


end


