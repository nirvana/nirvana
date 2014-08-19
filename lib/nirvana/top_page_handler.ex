defmodule Nirvana.TopPageHandler do
     @moduledoc """
      Module that implements cowboy http handler

      """
   
      @doc """
      Init does setup for handling the request. Can do protocol escalation.
      Third parameter is the list of ops defined in the cowboy routing table.
      This parameter is not changed during the life of the cowboy program.
        Returns: Protocol escalation tuple, or {:ok, req, state}
        - Returned state is delivered to subsequent calls within the handler (specifcially handle)
 
      """
  def init(_transport, req, [dbHash]) do
    {:ok, req, dbHash}
  end

	@doc "handle http request"
  def handle(req, state) do
 #   IO.puts "handle, load_module first time"
 #   Nirvana.TopPageHandler.load_module("example")
    IO.puts "handle load_module second time"
    module = Nirvana.TopPageHandler.load_module("mtest")
   #now we have a dict with an elixir module under they key "code"
    reason = ""
    try do
      module.handle(req, state) #ntest calls cowboy_req.reply itself
    rescue
      x in [RuntimeError] ->
        # all exceptions respond to message
        reason = reason <> x.message
      :cowboy_req.reply(400, [], reason, req)
    end
    {:ok, req, state}
  end

  def load_module(key) do
    IO.puts "load_module for key #{key}"
    {key, _, dict} = Couchie.get(:cb, key)
    IO.puts "Key: #{key}"

    IO.puts "load_module phase 2"
    code = Dict.get(dict, "code", nil)
# Apparently this was deprecated
# ast = Code.string_to_ast!(code)
    quoted = Code.string_to_quoted(code)
    IO.puts "load_module 3"
    prefix = Module.concat(Nirvana, "String")
    Module.create prefix, quoted, []
    IO.puts "load_module 4 - module is: #{prefix}"
    prefix
  end

	@doc "cleanup here"
  def terminate(_reason, _req, _state), do: :ok
  end 

  