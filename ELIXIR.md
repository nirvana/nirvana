Elixir Notes




Records as guards:
==================================
defrecord FooRecord, a: 0

defmodule Bla do
  def bla(r=FooRecord[]) do
    IO.inspect r
  end
end

Bla.bla FooRecord.new
Bla.bla :oops

also:  when is_record(arecord, AmnesicRecord)do