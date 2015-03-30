defmodule CloudOS.ManagerAPI.Mixfile do
  use Mix.Project

  def project do
    [app: :cloudos_manager_api,
     version: "0.0.1",
     elixir: "~> 1.0",
     deps: deps]
  end

  # Configuration for the OTP application
  #
  # Type `mix help compile.app` for more information
  def application do
    [
      mod: {CloudOS.ManagerAPI, []},
      applications: [:logger, :cloudos_auth]
    ]
  end

  # Dependencies can be Hex packages:
  #
  #   {:mydep, "~> 0.3.0"}
  #
  # Or git/path repositories:
  #
  #   {:mydep, git: "https://github.com/elixir-lang/mydep.git", tag: "0.1.0"}
  #
  # Type `mix help deps` for more examples and options
  defp deps do
    [
      {:json, "~>0.3.0"},
      {:uuid, "~> 0.1.5" },
      {:cloudos_auth, git: "https://#{System.get_env("GITHUB_OAUTH_TOKEN")}:x-oauth-basic@github.com/UmbrellaCorporation-SecretProjectLab/cloudos_auth.git",
            ref: "2251db134a153312bdc64070ed05c944ed6e4b00"},
     
      #testing dependencies
      {:exvcr, "~> 0.3.3", only: :test},
      {:meck, "0.8.2", only: :test}
    ]
  end
end
