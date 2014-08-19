defmodule DB do
#  use Database.Behaviour # Need to create a behavior so we can build for multiple backend mappings

	@moduledoc """
	Database Utilities
	"""

	@doc """
		Setup- opens standard database connections for reuse elsewhere, sets up pools
	  	Returns: Hash of AmenesicCache records stored under bucket name for handlers to use to access the caches. 
	"""
	def setup() do
		# Using Couchie/cberl, we set our buckets on default host and use SASL with the pass being the bucket name.
		# Couchie.open(:nirvana, 5, 'localhost:8091', 'nirvana')
		# Note, this causes crash somewhere around 800 cummulative pool size.  Possibly opening a port in libCouchbase for each worker.
		HashDict.new |>
		open_bucket(:nirvana, 10, 'nirvana') |>
		open_bucket(:cache, 10, 'cache') |>
		open_bucket(:sync, 10, 'sync') |>
		open_bucket(:packages, 10, 'packages') |>
		open_bucket(:sessions, 50, 'sessions') |>
		open_bucket(:apps, 50, 'apps')
	end

	defp open_bucket(hash, name, connections, bucket) do # assumes bucketname, username and password are same, and configs same
		IO.puts "#{name}"
		ac = AmenesicCache.new(name: name, size: connections, bucket: bucket, user: bucket, password: bucket) 
		|> Amnesic.start 
		Dict.put(hash, name, ac)
	end

	@doc """
		Get- convenience function for DB access that doesn't care about CAS values

	  	Returns: Strips AmnesicRecord and returns just the value.
	"""
	def get(cache=AmnesicCache[], key) do
		{_, _, value} = Amnesic.get(cache, key)
		value
	end

	@doc """
		Get Direct- convenience function for DB access that doesn't care about CAS values

	  	Returns: Strips AmnesicRecord and returns just the value.
	"""
	def get_direct(cache=AmnesicCache[], key) do
		{_, _, value} = Amnesic.get_direct(cache, key)
		value
	end

	@doc """
		Set- convenience function for DB access that doesn't care about CAS values

	  	Creates AmnesicRecord around the value.
	"""
	def set(cache=AmnesicCache[], key, value) do
		Amnesic.set(cache, AmnesicRecord.new(key: key, value: value))
	end

end
