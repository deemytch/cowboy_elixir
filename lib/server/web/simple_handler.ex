defmodule CowboyElixir.SimpleHandler do

  require Logger
  def init(%{ path: "/" } = req, opts) do
    Logger.info("SIMPLE #{req.method} #{req.path}?#{req.qs} #{req.headers["user-agent"]}")
    hdrs = %{"content-type" => "application/json"}
    bdy = "#{ inspect( req, pretty: true) }\n---\n#{ inspect opts}\n\n"
    resp = :cowboy_req.reply(200, hdrs, bdy, req)
    {:ok, resp, :empty}
  end
end
