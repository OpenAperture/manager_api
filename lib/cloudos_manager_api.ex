defmodule CloudOS.ManagerAPI do
	use Application

  # See http://elixir-lang.org/docs/stable/elixir/Application.html
  # for more information on OTP Applications
  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    children = [
      supervisor(CloudOS.ManagerAPI.Supervisor, []),
    ]

    opts = [strategy: :one_for_one]
    Supervisor.start_link(children, opts)
  end

  def get_api() do
    CloudOS.ManagerAPI.Supervisor.get_api
  end

	#start with supervisor
	def start(_type, args) do
		create(%{
			url: Keyword.get(args, :url),
			client_id: Keyword.get(args, :client_id),
			client_secret: Keyword.get(args, :client_secret)
		})
	end

	#start with supervisor
	def start_link(opts) do
		create(opts)
	end

  def create(opts) do
    Agent.start_link(fn -> opts end)
  end

  def create!(opts) do
    case create(opts) do
    	{:ok, pid} -> pid
    	{:error, reason} -> raise "Failed to start ManagerAPI:  #{inspect reason}"
    end
  end

  def get_options(api) do
  	Agent.get(api, fn opts -> opts end)
  end
end
