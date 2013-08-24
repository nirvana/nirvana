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
      {:couchie, github: "nirvana/couchie", override: true},  # included by amnesic
		  {:amnesic, github: "nirvana/amnesic"},
      {:flaky, github: "nirvana/flaky"},
#      {:erldns, github: "aetrion/erl-dns"},   #currently not compiling because /include is not being picked up.
      {:cowboy, github: "extend/cowboy"}]
  end
end

## Elli: knutin/elli

## 	 {:couchie, github: "nirvana/couchie"}  
## 	 {:couchie, github: "n1rvana/couchie"}   
## 	 {:cberl, github: "aliyakamercan/cberl"}   #Change this "n1rvana/cberl" or chitika/cberl
##      {:jsx,  github: "talentdeficit/jsx"},

# to add:
# yrashk / exconfig
# - any deps of rebar deps
