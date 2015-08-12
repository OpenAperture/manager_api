#
# == supervisor.ex
#
# This module contains the supervisor logic for the ManagerApi (when run as an application).
#
#
require Logger

defmodule OpenAperture.ManagerApi.Supervisor do
  use Supervisor

  @moduledoc """
  This module contains the supervisor logic for the ManagerApi (when run as an application).
  """ 

  @doc """
  Method to start the supervisor as a process tied to the current supervision tree

  ## Return values

  If the supervisor is successfully created and initialized, the function returns
  `{:ok, pid}`, where pid is the pid of the supervisor. If there already exists a
  process with the specified supervisor name, the function returns
  `{:error, {:already_started, pid}}` with the pid of that process.

  If the `init/1` callback fails with `reason`, the function returns
  `{:error, reason}`. Otherwise, if it returns `{:stop, reason}`

  or `:ignore`, the process is terminated and the function returns
  `{:error, reason}` or `:ignore`, respectively.
  """ 
  @spec start_link() :: Supervisor.on_start
  def start_link do
    Logger.info("Starting OpenAperture.ManagerApi.Supervisor...")
    Supervisor.start_link(__MODULE__, [], name: __MODULE__)
  end

  @doc """
  Method to initialize the supervisor

  ## Return values

  {:ok, state} | {:error, reason}
  """   
  @spec init([]) :: {:ok, term} | {:error, String.t}
  def init([]) do
    children = [
      worker(OpenAperture.ManagerApi, [%{
        manager_url: Application.get_env(:openaperture_manager_api, :manager_url, ""),
        oauth_login_url: Application.get_env(:openaperture_manager_api, :oauth_login_url, ""),
        oauth_client_id: Application.get_env(:openaperture_manager_api, :oauth_client_id, ""),
        oauth_client_secret: Application.get_env(:openaperture_manager_api, :oauth_client_secret, "")}])
    ]

    supervise(children, strategy: :one_for_one)
  end

  @doc """
  Method to return the global ManagerApi instance, when ManagerApi is started as an application.

  ## Return values

  pid
  """ 
  @spec get_api() :: pid
  def get_api do
    supervisor = Process.whereis(__MODULE__)
    if supervisor == nil do
      Logger.error("Unable to retrieve supervised OpenAperture.ManagerApi because the supervisor is invalid!")
      nil
    else
      children = Supervisor.which_children(supervisor)
      {_module, superivsed_pid, _type, _args} = List.first(children)
      superivsed_pid
    end
  end
end