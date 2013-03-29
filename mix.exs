defmodule Nirvana.Mixfile do
  use Mix.Project
  @moduledoc """
   Mixfile for the Nirvana OTP App.

   ## To run as daemon:

       $ mix run --no-halt
  ## To run interactively:

      $ iex -S mix

   """
   
  @doc "Project Details"
  def project do
    [ app: :nirvana,
      version: "0.0.1",
      deps: deps ]
  end

  @doc "Configuration for the OTP application"
  def application do
    [ mod: { Nirvana, [] },
      applications: [:cowboy] ]
  end
  
  defp deps do
    [ 
		  {:couchie, github: "nirvana/couchie"},
      {:ranch,  github: "extend/ranch", tag: "0.6.1"},
      {:cowboy, github: "extend/cowboy"}]
  end
end
## 	 {:couchie, github: "nirvana/couchie"}  
## 	 {:couchie, github: "n1rvana/couchie"}   
## 	 {:cberl, github: "aliyakamercan/cberl"}   #Change this "n1rvana/cberl" or chitika/cberl
##      {:jsx,  github: "talentdeficit/jsx"},

# to add:
# yrashk / exconfig
# - any deps of rebar deps
