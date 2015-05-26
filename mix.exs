defmodule ManagerApi.Mixfile do
  use Mix.Project

  def project do
    [app: :openaperture_manager_api,
     version: "0.0.1",
     elixir: "~> 1.0",
     deps: deps]
  end

  # Configuration for the OTP application
  #
  # Type `mix help compile.app` for more information
  def application do
    [
      mod: {OpenAperture.ManagerApi, []},
      applications: [:logger, :openaperture_auth]
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
      {:ex_doc, "0.7.3", only: :test},
      {:earmark, "0.1.17", only: :test},
      {:json, "~>0.3.0"},
      {:uuid, "~> 0.1.5" },
      {:openaperture_auth, git: "https://github.com/OpenAperture/auth.git",
            ref: "0ded31f747cb0b781838b5799acadcda88dd7953"},
     
      #testing dependencies
      {:exvcr, "~> 0.3.3", only: :test},
      {:meck, "0.8.2", only: :test}
    ]
  end
end
