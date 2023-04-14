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
    {
      [
        {{ "application", "json", :"*" }, :answer },
        {{ "application", "yaml", :"*" }, :answer },
        {{ "text", "plain", :"*" }, :answer },
      ],
      req,
      state
    }
  end

  def content_types_accepted(req, state) do
    Logger.info("content_types_accepted()")
    {:answer, req, state}
  end

  def answer(req, state) do
    Logger.info("Вызван answer()")
    body = "#{ inspect( req, pretty: true) }\n---\n#{ inspect state}\n\n"
    {body, req, state}
  end

end