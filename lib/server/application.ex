defmodule CowboyElixir.Application do
  @moduledoc """
    запуск ковбоя
    https://gist.github.com/mpugach/9093f092f63e5b91f08a8ac116684d66
  """

  use Application
  require Logger

  @impl true
  def start(_type, _args) do
    Supervisor.start_link(
      [cowboy_spec()],
      [strategy: :one_for_one, name: CowboyElixir.Supervisor]
    )
  end

  def cowboy_spec() do
    routes = :cowboy_router.compile(
      [{:_, [
          {"/", CowboyElixir.SimpleHandler, %{method: :get}},
          {"/rest", CowboyElixir.RESTHandler, %{lang: [:ru,:he]}}
      ]}] )

    %{
      id: :yamlapi,
      start: {
        :cowboy, :start_clear, [
          :yamlapi,
          %{max_connections: 999999, socket_opts: [port: 3700]},
          %{max_keepalive: 1000, env: %{ dispatch: routes }}
      ]},
      restart: :permanent,
      shutdown: :infinity,
      type: :supervisor
    }
  end
end
