defmodule CowboyElixir.MixProject do
  use Mix.Project

  def project do
    [
      app: :cowboy_elixir,
      version: "0.1.0",
      elixir: "~> 1.14",
      start_permanent: Mix.env() == :prod,
      deps: [
        cowboy: "~> 2.9",
        ymlr: "~> 3.0",
        json: "~> 1.4"
    ]]
  end

  def application do
    [
      extra_applications: [:logger],
      mod: {CowboyElixir.Application, []}
    ]
  end

end
