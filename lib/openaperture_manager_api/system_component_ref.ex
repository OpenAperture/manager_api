#
# == system_component_ref.ex
#
# This module contains the resources for managing SystemComponentRef
#
defmodule OpenAperture.ManagerApi.SystemComponentRef do
  import OpenAperture.ManagerApi.Resource

  alias OpenAperture.ManagerApi
  alias OpenAperture.ManagerApi.Response

  @moduledoc """
  This module contains the resources for managing SystemComponentRefs
  """

  @doc """
  Retrieves the entire list of SystemComponentRefs.

  ## Options
  The `api` option defines the OpenAperture.ManagerApi used for connection.

  The `queryparams` option defines the query parameters (optional).

  The `headers` option defines the header values (optional).

  The `options` option defines any extra HTTP options (optional).

  ## Return Values

  Returns the OpenAperture.ManagerApi.Response struct.
  """
  @spec list(pid, map, list, list) :: term
  def list(api \\ ManagerApi.get_api, queryparams \\ %{}, headers \\ [], options \\ []) do
    get(api, get_path("system_component_refs", queryparams), headers, options)
  end

  @doc """
  Retrieves the entire list of SystemComponentRefs.

  ## Options
  The `api` option defines the OpenAperture.ManagerApi used for connection.

  The `queryparams` option defines the query parameters (optional).

  The `headers` option defines the header values (optional).

  The `options` option defines any extra HTTP options (optional).

  ## Return Values

  Returns nil (if failure) or a list of Maps, each representing a SystemComponentRef.
  """
  @spec list!(pid, map, list, list) :: list[map] | nil
  def list!(api \\ ManagerApi.get_api, queryparams \\ %{}, headers \\ [], options \\ []) do
    response = list(api, queryparams, headers, options)
    if response.success? do
      response.body
    else
      nil
    end
  end

  @doc """
  Retrieves a specific SystemComponentRef.

  ## Options
  The `api` option defines the OpenAperture.ManagerApi used for connection.

  The `type` option defines the SystemComponentRef type.

  The `queryparams` option defines the query parameters (optional).

  The `headers` option defines the header values (optional).

  The `options` option defines any extra HTTP options (optional).

  ## Return Values

  Returns the OpenAperture.ManagerApi.Response struct.
  """
  @spec get_system_component_ref(pid, term, map, list, list) :: term
  def get_system_component_ref(api \\ ManagerApi.get_api, type, queryparams \\ %{}, headers \\ [], options \\ []) do
    get(api, get_path("system_component_refs/#{type}", queryparams), headers, options)
  end

  @doc """
  Retrieves a specific SystemComponentRef.

  ## Options
  The `api` option defines the OpenAperture.ManagerApi used for connection.

  The `type` option defines the SystemComponentRef type.

  The `queryparams` option defines the query parameters (optional).

  The `headers` option defines the header values (optional).

  The `options` option defines any extra HTTP options (optional).

  ## Return Values

  Map of the SystemComponentRef
  """
  @spec get_system_component_ref!(pid, term, map, list, list) :: map | nil
  def get_system_component_ref!(api \\ ManagerApi.get_api, type, queryparams \\ %{}, headers \\ [], options \\ []) do
    response = get_system_component_ref(api, type, queryparams, headers, options)
    if response.success? do
      response.body
    else
      nil
    end
  end

  @doc """
  Create a SystemComponentRef.

  ## Options
  The `api` option defines the OpenAperture.ManagerApi used for connection.

  The `component` option defines the SystemComponentRef map.

  The `queryparams` option defines the query parameters (optional).

  The `headers` option defines the header values (optional).

  The `options` option defines any extra HTTP options (optional).

  ## Return Values

  Returns the OpenAperture.ManagerApi.Response struct.
  """
  @spec create_system_component_ref(pid, map, map, list, list) :: term
  def create_system_component_ref(api \\ ManagerApi.get_api, component, queryparams \\ %{}, headers \\ [], options \\ []) do
    post(api, get_path("system_component_refs", queryparams), component, headers, options)
  end

  @doc """
  Create a SystemComponentRef.

  ## Options
  The `api` option defines the OpenAperture.ManagerApi used for connection.

  The `component` option defines the SystemComponentRef map.

  The `queryparams` option defines the query parameters (optional).

  The `headers` option defines the header values (optional).

  The `options` option defines any extra HTTP options (optional).

  ## Return Values

  Integer of new SystemComponentRef, or nil
  """
  @spec create_system_component_ref!(pid, map, map, list, list) :: term | nil
  def create_system_component_ref!(api \\ ManagerApi.get_api, component, queryparams \\ %{}, headers \\ [], options \\ []) do
    response = create_system_component_ref(api, component, queryparams, headers, options)
    if response.success? do
      Response.extract_identifier_from_location_header(response)
    else
      nil
    end
  end

  @doc """
  Update a SystemComponentRef.

  ## Options
  The `api` option defines the OpenAperture.ManagerApi used for connection.

  The `component` option defines the SystemComponentRef map.

  The `type` option defines the SystemComponentRef type.

  The `queryparams` option defines the query parameters (optional).

  The `headers` option defines the header values (optional).

  The `options` option defines any extra HTTP options (optional).

  ## Return Values

  Returns the OpenAperture.ManagerApi.Response struct.
  """
  @spec update_system_component_ref(pid, String.t, map, map, list, list) :: term
  def update_system_component_ref(api \\ ManagerApi.get_api, type, component, queryparams \\ %{}, headers \\ [], options \\ []) do
    put(api, get_path("system_component_refs/#{type}", queryparams), component, headers, options)
  end

  @doc """
  Update a SystemComponentRef.

  ## Options
  The `api` option defines the OpenAperture.ManagerApi used for connection.

  The `component` option defines the SystemComponentRef map.

  The `type` option defines the SystemComponentRef type.

  The `queryparams` option defines the query parameters (optional).

  The `headers` option defines the header values (optional).

  The `options` option defines any extra HTTP options (optional).

  ## Return Values

  Integer of new component, or nil
  """
  @spec update_system_component_ref!(pid, String.t, map, map, list, list) :: term | nil
  def update_system_component_ref!(api \\ ManagerApi.get_api, type, component, queryparams \\ %{}, headers \\ [], options \\ []) do
    response = update_system_component_ref(api, type, component, queryparams, headers, options)
    if response.success? do
      Response.extract_identifier_from_location_header(response)
    else
      nil
    end
  end

  @doc """
  Delete a SystemComponentRef.

  ## Options
  The `api` option defines the OpenAperture.ManagerApi used for connection.

  The `type` option defines the SystemComponentRef type.

  The `queryparams` option defines the query parameters (optional).

  The `headers` option defines the header values (optional).

  The `options` option defines any extra HTTP options (optional).

  ## Return Values

  Returns the OpenAperture.ManagerApi.Response struct.
  """
  @spec delete_system_component_ref(pid, String.t, map, list, list) :: term
  def delete_system_component_ref(api \\ ManagerApi.get_api, type, queryparams \\ %{}, headers \\ [], options \\ []) do
    delete(api, get_path("system_component_refs/#{type}", queryparams), headers, options)
  end

  @doc """
  Delete a SystemComponentRef.

  ## Options
  The `api` option defines the OpenAperture.ManagerApi used for connection.

  The `type` option defines the SystemComponentRef type.

  The `queryparams` option defines the query parameters (optional).

  The `headers` option defines the header values (optional).

  The `options` option defines any extra HTTP options (optional).

  ## Return Values

  Boolean
  """
  @spec delete_system_component_ref!(pid, String.t,  map, list, list) :: term
  def delete_system_component_ref!(api \\ ManagerApi.get_api, type, queryparams \\ %{}, headers \\ [], options \\ []) do
    delete_system_component_ref(api, type, queryparams, headers, options).success?
  end
end