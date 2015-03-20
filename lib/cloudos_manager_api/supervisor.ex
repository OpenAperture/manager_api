require Logger

defmodule CloudOS.ManagerAPI.Supervisor do
  use Supervisor

  def start_link do
    IO.puts("Starting CloudOS.ManagerAPI.Supervisor...")
    Supervisor.start_link(__MODULE__, [], name: __MODULE__)
  end

  def init([]) do
    children = [
      worker(CloudOS.ManagerAPI, [%{
        url: Application.get_env(:cloudos_manager_api, :url, ""), 
        client_id: Application.get_env(:cloudos_manager_api, :client_id, ""), 
        client_secret: Application.get_env(:cloudos_manager_api, :client_secret, "")}])
    ]

    supervise(children, strategy: :one_for_one)
  end

  def get_api do
    supervisor = Process.whereis(__MODULE__)
    if supervisor == nil do
      Logger.error("Unable to retrieve supervised CloudOS.ManagerAPI because the supervisor is invalid!")
      nil
    else
      children = Supervisor.which_children(supervisor)
      {_module, superivsed_pid, _type, _args} = List.first(children)
      superivsed_pid
    end
  end
end