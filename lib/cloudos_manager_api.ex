#
# == cloudos_manager_api.ex
#
# This module contains the the application definition as well as the create options for CloudOS.ManagerAPI.  This 
# API library can be consumed either as an application (which can be supervised), or on a per-instance basis. 
#
defmodule CloudOS.ManagerAPI do
	use Application

  @moduledoc """
  This module contains the the application definition as well as the create options for CloudOS.ManagerAPI.  This 
  API library can be consumed either as an application (which can be supervised), or on a per-instance basis. 
  """ 

  @doc """
  Starts the application as a given `_type`.

  If the `_type` is not loaded, the application will first be loaded using `load/1`.
  Any included application, defined in the `:included_applications` key of the
  `.app` file will also be loaded, but they won't be started.

  Furthermore, all applications listed in the `:applications` key must be explicitly
  started before this application is. If not, `{:error, {:not_started, app}}` is
  returned, where `_type` is the name of the missing application.

  In case you want to automatically  load **and start** all of `_type`'s dependencies,
  see `ensure_all_started/2`.

  The `type` argument specifies the type of the application:
    * `:permanent` - if `_type` terminates, all other applications and the entire
      node are also terminated.
    * `:transient` - if `_type` terminates with `:normal` reason, it is reported
      but no other applications are terminated. If a transient application
      terminates abnormally, all other applications and the entire node are
      also terminated.
    * `:temporary` - if `_type` terminates, it is reported but no other
      applications are terminated (the default).
  
  Note that it is always possible to stop an application explicitly by calling
  `stop/1`. Regardless of the type of the application, no other applications will
  be affected.
  
  Note also that the `:transient` type is of little practical use, since when a
  supervision tree terminates, the reason is set to `:shutdown`, not `:normal`.
  """
  @spec start(atom, [any]) :: :ok | {:error, String.t()}
  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    children = [
      supervisor(CloudOS.ManagerAPI.Supervisor, []),
    ]

    opts = [strategy: :one_for_one]
    Supervisor.start_link(children, opts)
  end

  @doc """
  Method to start the ManagerAPI as a process tied to the current supervision tree (Required by the supervisor).

  ## Return values

  If the ManagerAPI is successfully created and initialized, the function returns
  `{:ok, pid}`, where pid is the pid of the ManagerAPI. If there already exists a
  process with the specified ManagerAPI name, the function returns
  `{:error, {:already_started, pid}}` with the pid of that process.

  If the `init/1` callback fails with `reason`, the function returns
  `{:error, reason}`. Otherwise, if it returns `{:stop, reason}`

  or `:ignore`, the process is terminated and the function returns
  `{:error, reason}` or `:ignore`, respectively.
  """	
	@spec start_link(Map) :: {:ok, pid} | {:error, String.t()}
	def start_link(opts) do
		create(opts)
	end

  @doc """
  Method to start the ManagerAPI as a process tied to the current supervision tree

  ## Return values

  If the ManagerAPI is successfully created and initialized, the function returns
  `{:ok, pid}`, where pid is the pid of the ManagerAPI. If there already exists a
  process with the specified ManagerAPI name, the function returns
  `{:error, {:already_started, pid}}` with the pid of that process.

  If the `init/1` callback fails with `reason`, the function returns
  `{:error, reason}`. Otherwise, if it returns `{:stop, reason}`
  
  or `:ignore`, the process is terminated and the function returns
  `{:error, reason}` or `:ignore`, respectively.
  """	
	@spec create(Map) :: {:ok, pid} | {:error, String.t()}
  def create(opts) do
    Agent.start_link(fn -> opts end)
  end

  @doc """
  Method to start the ManagerAPI as a process tied to the current supervision tree

  ## Return values

  pid or raises error
  """	
	@spec create!(Map) :: pid
  def create!(opts) do
    case create(opts) do
    	{:ok, pid} -> pid
    	{:error, reason} -> raise "Failed to start ManagerAPI:  #{inspect reason}"
    end
  end

  @doc """
  Method to return the global ManagerAPI instance, when ManagerAPI is started as an application.

  ## Return values

  pid
  """	
	@spec get_api() :: pid
  def get_api() do
    CloudOS.ManagerAPI.Supervisor.get_api
  end  

  @doc """
  Method to return options associated with a ManagerAPI instance

  ## Option Values

  The `api` option defines the ManagerAPI instance pid

  ## Return values

  Map
  """	
	@spec get_options(pid) :: Map
  def get_options(api) do
  	Agent.get(api, fn opts -> opts end)
  end
end