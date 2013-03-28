defmodule Nirvana.TopPageHandler do
     @moduledoc """
      Module that implements cowboy http handler

      """
   
     @doc "init - setup for the handler"
  def init(_transport, req, []) do
    {:ok, req, nil}
  end

	@doc "handle http request"
  def handle(req, state) do
    key = "mtest"
    #now we have a dict with an elixir module under they key "code"
    reason = ""
    try do
      {key, _, dict} = Couchie.get(:cb, key)
      code = Dict.get!(dict, "code")
      ast = Code.string_to_ast!(code)
      module = Module.concat(Nirvana, "Version1")
      Module.create module, ast, []
      module.handle(req, state) #ntest calls cowboy_req.reply itself
    rescue
      x in [RuntimeError] ->
        # all exceptions respond to message
        reason = reason <> x.message
      :cowboy_req.reply(400, [], reason, req)
    end
    {:ok, req, state}
  end

	@doc "cleanup here"
  def terminate(_reason, _req, _state), do: :ok
  end 

  