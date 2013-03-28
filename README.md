Nirvana Web Platform
====================


Under heavy development, testing several technologies. Won't be ready to open source for awhile.

http://localhost:8196

NOTE: This repository is LOCAL ONLY.  Until we have a paid github account (and have gotten github.com/nirvana!) we're just working here and leting time machine have our back.


======================

This is an example of running Cowboy with [Elixir](http://elixir-lang.org).

You need Elixir installed
([instructions here](http://elixir-lang.org/getting_started/1.html))
to run this example. After installing Elixir, you should have both
`elixir` and `mix` executables available.

You also need [rebar](https://github.com/rebar/rebar) in your PATH
to compile dependencies.

Then type the following command:

```
mix deps.get
```

The command above will fetch all dependencies and compile them.

You can then start the Erlang node with the following command:

```
mix run --no-halt
```
To start in interactive mode with iex:

```
iex -S mix
```


Then point your browser to localhost:8080.

Example
-------

``` bash
$ curl -i http://localhost:8080
HTTP/1.1 200 OK
connection: keep-alive
server: Cowboy
date: Fri, 28 Sep 2012 04:10:25 GMT
content-length: 12

Hello world!
```
