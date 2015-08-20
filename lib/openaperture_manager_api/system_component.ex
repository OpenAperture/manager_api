#
# == system_component.ex
#
# This module contains the resources for managing SystemComponents
#
defmodule OpenAperture.ManagerApi.SystemComponent do
  import OpenAperture.ManagerApi.Resource

  alias OpenAperture.ManagerApi
  alias OpenAperture.ManagerApi.Response

  @moduledoc """
  This module contains the resources for managing SystemComponents
  """

  @doc """
  Retrieves the entire list of SystemComponents.

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
    get(api, get_path("system_components", queryparams), headers, options)
  end

  @doc """
  Retrieves the entire list of SystemComponents.

  ## Options
  The `api` option defines the OpenAperture.ManagerApi used for connection.

  The `queryparams` option defines the query parameters (optional).

  The `headers` option defines the header values (optional).

  The `options` option defines any extra HTTP options (optional).

  ## Return Values

  Returns nil (if failure) or a list of Maps, each representing a SystemComponent.
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
  Retrieves a specific SystemComponent.

  ## Options
  The `api` option defines the OpenAperture.ManagerApi used for connection.

  The `id` option defines the SystemComponent id.

  The `queryparams` option defines the query parameters (optional).

  The `headers` option defines the header values (optional).

  The `options` option defines any extra HTTP options (optional).

  ## Return Values

  Returns the OpenAperture.ManagerApi.Response struct.
  """
  @spec get_system_component(pid, term, map, list, list) :: term
  def get_system_component(api \\ ManagerApi.get_api, id, queryparams \\ %{}, headers \\ [], options \\ []) do
    get(api, get_path("system_components/#{id}", queryparams), headers, options)
  end

  @doc """
  Retrieves a specific SystemComponent.

  ## Options
  The `api` option defines the OpenAperture.ManagerApi used for connection.

  The `id` option defines the SystemComponent id.

  The `queryparams` option defines the query parameters (optional).

  The `headers` option defines the header values (optional).

  The `options` option defines any extra HTTP options (optional).

  ## Return Values

  Map of the SystemComponent
  """
  @spec get_system_component!(pid, term, map, list, list) :: map | nil
  def get_system_component!(api \\ ManagerApi.get_api, id, queryparams \\ %{}, headers \\ [], options \\ []) do
    response = get_system_component(api, id, queryparams, headers, options)
    if response.success? do
      response.body
    else
      nil
    end
  end

  @doc """
  Create a SystemComponent.

  ## Options
  The `api` option defines the OpenAperture.ManagerApi used for connection.

  The `component` option defines the SystemComponent map.

  The `queryparams` option defines the query parameters (optional).

  The `headers` option defines the header values (optional).

  The `options` option defines any extra HTTP options (optional).

  ## Return Values

  Returns the OpenAperture.ManagerApi.Response struct.
  """
  @spec create_system_component(pid, map, map, list, list) :: term
  def create_system_component(api \\ ManagerApi.get_api, component, queryparams \\ %{}, headers \\ [], options \\ []) do
    post(api, get_path("system_components", queryparams), component, headers, options)
  end

  @doc """
  Create a SystemComponent.

  ## Options
  The `api` option defines the OpenAperture.ManagerApi used for connection.

  The `component` option defines the SystemComponent map.

  The `queryparams` option defines the query parameters (optional).

  The `headers` option defines the header values (optional).

  The `options` option defines any extra HTTP options (optional).

  ## Return Values

  Integer of new SystemComponent, or nil
  """
  @spec create_system_component!(pid, map, map, list, list) :: term | nil
  def create_system_component!(api \\ ManagerApi.get_api, component, queryparams \\ %{}, headers \\ [], options \\ []) do
    response = create_system_component(api, component, queryparams, headers, options)
    if response.success? do
      Response.extract_identifier_from_location_header(response)
    else
      nil
    end
  end

  @doc """
  Update a SystemComponent.

  ## Options
  The `api` option defines the OpenAperture.ManagerApi used for connection.

  The `component` option defines the SystemComponent map.

  The `id` option defines the SystemComponent id.

  The `queryparams` option defines the query parameters (optional).

  The `headers` option defines the header values (optional).

  The `options` option defines any extra HTTP options (optional).

  ## Return Values

  Returns the OpenAperture.ManagerApi.Response struct.
  """
  @spec update_system_component(pid, String.t, map, map, list, list) :: term
  def update_system_component(api \\ ManagerApi.get_api, id, component, queryparams \\ %{}, headers \\ [], options \\ []) do
    put(api, get_path("system_components/#{id}", queryparams), component, headers, options)
  end

  @doc """
  Update a SystemComponent.

  ## Options
  The `api` option defines the OpenAperture.ManagerApi used for connection.

  The `component` option defines the SystemComponent map.

  The `id` option defines the SystemComponent id.

  The `queryparams` option defines the query parameters (optional).

  The `headers` option defines the header values (optional).

  The `options` option defines any extra HTTP options (optional).

  ## Return Values

  Integer of new component, or nil
  """
  @spec update_system_component!(pid, String.t, map, map, list, list) :: term | nil
  def update_system_component!(api \\ ManagerApi.get_api, id, component, queryparams \\ %{}, headers \\ [], options \\ []) do
    response = update_system_component(api, id, component, queryparams, headers, options)
    if response.success? do
      Response.extract_identifier_from_location_header(response)
    else
      nil
    end
  end

  @doc """
  Delete a SystemComponent.

  ## Options
  The `api` option defines the OpenAperture.ManagerApi used for connection.

  The `id` option defines the SystemComponent id.

  The `queryparams` option defines the query parameters (optional).

  The `headers` option defines the header values (optional).

  The `options` option defines any extra HTTP options (optional).

  ## Return Values

  Returns the OpenAperture.ManagerApi.Response struct.
  """
  @spec delete_system_component(pid, String.t, map, list, list) :: term
  def delete_system_component(api \\ ManagerApi.get_api, id, queryparams \\ %{}, headers \\ [], options \\ []) do
    delete(api, get_path("system_components/#{id}", queryparams), headers, options)
  end

  @doc """
  Delete a SystemComponent.

  ## Options
  The `api` option defines the OpenAperture.ManagerApi used for connection.

  The `id` option defines the SystemComponent id.

  The `queryparams` option defines the query parameters (optional).

  The `headers` option defines the header values (optional).

  The `options` option defines any extra HTTP options (optional).

  ## Return Values

  Boolean
  """
  @spec delete_system_component!(pid, String.t,  map, list, list) :: term
  def delete_system_component!(api \\ ManagerApi.get_api, id, queryparams \\ %{}, headers \\ [], options \\ []) do
    delete_system_component(api, id, queryparams, headers, options).success?
  end
end
