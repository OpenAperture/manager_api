#
# == system_event.ex
#
# This module contains the resources for managing SystemEvents
#
defmodule OpenAperture.ManagerApi.SystemEvent do
  import OpenAperture.ManagerApi.Resource

  alias OpenAperture.ManagerApi

  @moduledoc """
  This module contains the resources for managing SystemEvents
  """  

  @doc """
  Retrieves the entire list of SystemEvents. 

  ## Options
  The `api` option defines the OpenAperture.ManagerApi used for connection.

  The `queryparams` option defines the query parameters (optional).

  The `headers` option defines the header values (optional).

  The `options` option defines any extra HTTP options (optional).

  ## Return Values

  Returns the OpenAperture.ManagerApi.Response struct.
  """
  @spec list(pid, Map, List, List) :: term
  def list(api \\ ManagerApi.get_api, queryparams \\ %{}, headers \\ [], options \\ []) do
    get(api, get_path("system_events", queryparams), headers, options)
  end

  @doc """
  Retrieves the entire list of SystemEvents. 

  ## Options
  The `api` option defines the OpenAperture.ManagerApi used for connection.

  The `queryparams` option defines the query parameters (optional).

  The `headers` option defines the header values (optional).

  The `options` option defines any extra HTTP options (optional).

  ## Return Values

  Returns nil (if failure) or a list of Maps, each representing a SystemEvent.
  """
  @spec list(pid, Map, List, List) :: List[Map]
  def list!(api \\ ManagerApi.get_api, queryparams \\ %{}, headers \\ [], options \\ []) do
    response = list(api, queryparams, headers, options)
    if response.success? do
      response.body
    else
      nil
    end
  end

  @doc """
  Create a SystemEvent.

  ## Options
  The `api` option defines the OpenAperture.ManagerApi used for connection.

  The `event` option defines the SystemEvent map.

  The `queryparams` option defines the query parameters (optional).

  The `headers` option defines the header values (optional).

  The `options` option defines any extra HTTP options (optional).

  ## Return Values

  Returns the OpenAperture.ManagerApi.Response struct.
  """
  @spec create_system_event(pid, Map, Map, List, List) :: term
  def create_system_event(api \\ ManagerApi.get_api, event, queryparams \\ %{}, headers \\ [], options \\ []) do
    post(api, get_path("system_events", queryparams), event, headers, options)
  end

  @doc """
  Create a SystemEvent.

  ## Options
  The `api` option defines the OpenAperture.ManagerApi used for connection.

  The `event` option defines the SystemEvent map.

  The `queryparams` option defines the query parameters (optional).

  The `headers` option defines the header values (optional).

  The `options` option defines any extra HTTP options (optional).

  ## Return Values

  Boolean
  """
  @spec create_system_event!(pid, Map, Map, List, List) :: term
  def create_system_event!(api \\ ManagerApi.get_api, event, queryparams \\ %{}, headers \\ [], options \\ []) do
    response = create_system_event(api, event, queryparams, headers, options)
    response.success?
  end
end
