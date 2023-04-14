# Example of Cowboy on Elixir

I made a try to draft an example of the simple service with cowboy on elixir.

## Manually testing

`iex -S mix`

```
% curl -vv 'http://localhost:3700/rest?cover=25&dat=begs'
% curl -vv 'http://localhost:3700/
% curl -vv -X PUT 'http://localhost:3700/rest'
```

## Cowboy request

```elixir
%{
  bindings: %{},
  body_length: 0,
  cert: :undefined,
  has_body: false,
  headers: %{
    "accept" => "*/*",
    "host" => "localhost:3700",
    "user-agent" => "curl/8.0.1"
  },
  host: "localhost",
  host_info: :undefined,
  method: "GET",
  path: "/",
  path_info: :undefined,
  peer: {{127, 0, 0, 1}, 37334},
  pid: _pid,
  port: 3700,
  qs: "",
  ref: :yamlapi,
  scheme: "http",
  sock: {{127, 0, 0, 1}, 3700},
  streamid: 1,
  version: :"HTTP/1.1"
}
```

