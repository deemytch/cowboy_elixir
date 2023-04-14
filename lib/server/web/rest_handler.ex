defmodule CowboyElixir.RESTHandler do
  require Logger
  @moduledoc """
  https://ninenines.eu/docs/en/cowboy/2.6/guide/rest_flowcharts/
  https://ninenines.eu/docs/en/cowboy/2.9/manual/cowboy_rest/
  """

  def init(%{ path: "/rest" } = req, _opts) do
    Logger.info("REST #{req.method} #{req.path}?#{req.qs} #{req.headers["user-agent"]}")
    {:cowboy_rest, req, :empty}
  end

  def terminate( reason, req, _state) do
    Logger.info("КОНЕЦ #{req.method} #{req.path}?#{req.qs} #{req.headers["user-agent"]} #{inspect reason}")
    :ok
  end

  def allowed_methods(req, state) do
    Logger.info("allowed_methods()")
    {~W[GET PUT], req, state}
  end

  def malformed_request(req, state) do
    Logger.info("malformed_request()")
    {false, req, state}
  end

  def content_types_provided(req, state) do
    Logger.info("content_types_provided()")
    { [
        {{ "application", "yaml", :"*" }, :to_yaml },
        {{ "text", "plain", :"*" }, :to_text },
        {{ "application", "json", :"*" }, :to_json },
      ],
      req,
      state
    }
  end

  def content_types_accepted(req, state) do
    Logger.info("content_types_accepted()")
    { [
        {{ "application", "yaml", :"*" }, :to_yaml },
        {{ "text", "plain", :"*" }, :to_text },
        {{ "application", "json", :"*" }, :to_json },
      ],
      req,
      state
    }
  end

  def to_text(req, state) do
    Logger.info("Вызван to_text()")
    body = "#{ inspect( req, pretty: true) }\n---\n#{ inspect state}\n\n"
    {body, req, state}
  end

  def to_json(req, state) do
    Logger.info("Вызван to_json()")
    body = JSON.encode!( req )
    { body, req, state }
  end

  def to_yaml(req, state) do
    Logger.info("Вызван to_yaml()")
    body =
      %{ req |
          peer: unroll_addr( req.peer ),
          sock: unroll_addr( req.sock ),
          pid: :erlang.pid_to_list( req.pid )
      } |> Enum.map( fn {k,v} when is_tuple(v) ->
                    {k, :erlang.tuple_to_list(v)}
                  {k,v} -> {k,v}
              end )
        |> Enum.into(%{})
        |> Ymlr.document!()
    { body, req, state }
  end

  def unroll_addr({ip, port}),
  do: :erlang.tuple_to_list(ip)
      |> :lists.append([port])

end
