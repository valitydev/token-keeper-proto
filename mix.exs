defmodule TokenKeeperProto.MixProject do
  use Mix.Project

  def project do
    [
      app: :token_keeper_proto,
      version: "0.1.0",
      elixir: "~> 1.14",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      compilers: [:thrift | Mix.compilers],
      thrift: [
        files: Path.wildcard("proto/*.thrift"),
        include_paths: [Path.join(base_deps_path(), "bouncer_proto")]
      ]
    ]
  end

  def application, do: []

  defp deps do
    [
      {:bouncer_proto, git: "https://github.com/valitydev/bouncer-proto.git", branch: "TD-421/mix-project"},
      {:thrift, git: "https://github.com/pinterest/elixir-thrift", branch: "master"}
    ]
  end

  defp base_deps_path do
    # Why
    case Mix.ProjectStack.peek() do
      nil -> Mix.Project.deps_path();
      project -> Path.join(Path.dirname(project[:file]), "deps")
    end
  end
end
