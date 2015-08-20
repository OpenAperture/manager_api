#
# == messaging_rpc_request.ex
#
# This module contains the resources for managing MessagingRpcRequests
#
defmodule OpenAperture.ManagerApi.MessagingRpcRequest do
  import OpenAperture.ManagerApi.Resource

  alias OpenAperture.ManagerApi
  alias OpenAperture.ManagerApi.Response

  @moduledoc """
  This module contains the resources for managing MessagingRpcRequests
  """

  @doc """
  Retrieves the entire list of MessagingRpcRequests.

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
    get(api, get_path("messaging/rpc_requests", queryparams), headers, options)
  end

  @doc """
  Retrieves the entire list of MessagingRpcRequests.

  ## Options
  The `api` option defines the OpenAperture.ManagerApi used for connection.

  The `queryparams` option defines the query parameters (optional).

  The `headers` option defines the header values (optional).

  The `options` option defines any extra HTTP options (optional).

  ## Return Values

  Returns nil (if failure) or a list of Maps, each representing a MessagingRpcRequest.
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
  Retrieves a specific MessagingRpcRequest.

  ## Options
  The `api` option defines the OpenAperture.ManagerApi used for connection.

  The `id` option defines the MessagingRpcRequest id.

  The `queryparams` option defines the query parameters (optional).

  The `headers` option defines the header values (optional).

  The `options` option defines any extra HTTP options (optional).

  ## Return Values

  Returns the OpenAperture.ManagerApi.Response struct.
  """
  @spec get_request(pid, term, map, list, list) :: term
  def get_request(api \\ ManagerApi.get_api, id, queryparams \\ %{}, headers \\ [], options \\ []) do
    get(api, get_path("messaging/rpc_requests/#{id}", queryparams), headers, options)
  end

  @doc """
  Retrieves a specific MessagingRpcRequest.

  ## Options
  The `api` option defines the OpenAperture.ManagerApi used for connection.

  The `id` option defines the MessagingRpcRequest id.

  The `queryparams` option defines the query parameters (optional).

  The `headers` option defines the header values (optional).

  The `options` option defines any extra HTTP options (optional).

  ## Return Values

  Map of the MessagingRpcRequest
  """
  @spec get_request!(pid, term, map, list, list) :: map | nil
  def get_request!(api \\ ManagerApi.get_api, id, queryparams \\ %{}, headers \\ [], options \\ []) do
    response = get_request(api, id, queryparams, headers, options)
    if response.success? do
      response.body
    else
      nil
    end
  end

  @doc """
  Create a MessagingRpcRequest.

  ## Options
  The `api` option defines the OpenAperture.ManagerApi used for connection.

  The `request` option defines the MessagingRpcRequest map.

  The `queryparams` option defines the query parameters (optional).

  The `headers` option defines the header values (optional).

  The `options` option defines any extra HTTP options (optional).

  ## Return Values

  Returns the OpenAperture.ManagerApi.Response struct.
  """
  @spec create_request(pid, map, map, list, list) :: term
  def create_request(api \\ ManagerApi.get_api, request, queryparams \\ %{}, headers \\ [], options \\ []) do
    post(api, get_path("messaging/rpc_requests", queryparams), request, headers, options)
  end

  @doc """
  Create a MessagingRpcRequest.

  ## Options
  The `api` option defines the OpenAperture.ManagerApi used for connection.

  The `request` option defines the MessagingRpcRequest map.

  The `queryparams` option defines the query parameters (optional).

  The `headers` option defines the header values (optional).

  The `options` option defines any extra HTTP options (optional).

  ## Return Values

  Integer of new request, or nil
  """
  @spec create_request!(pid, map, map, list, list) :: term | nil
  def create_request!(api \\ ManagerApi.get_api, request, queryparams \\ %{}, headers \\ [], options \\ []) do
    response = create_request(api, request, queryparams, headers, options)
    if response.success? do
      Response.extract_identifier_from_location_header(response)
    else
      nil
    end
  end

  @doc """
  Update a MessagingRpcRequest.

  ## Options
  The `api` option defines the OpenAperture.ManagerApi used for connection.

  The `request` option defines the MessagingRpcRequest map.

  The `id` option defines the MessagingRpcRequest id.

  The `queryparams` option defines the query parameters (optional).

  The `headers` option defines the header values (optional).

  The `options` option defines any extra HTTP options (optional).

  ## Return Values

  Returns the OpenAperture.ManagerApi.Response struct.
  """
  @spec update_request(pid, String.t, map, map, list, list) :: term
  def update_request(api \\ ManagerApi.get_api, id, request, queryparams \\ %{}, headers \\ [], options \\ []) do
    put(api, get_path("messaging/rpc_requests/#{id}", queryparams), request, headers, options)
  end

  @doc """
  Update a MessagingRpcRequest.

  ## Options
  The `api` option defines the OpenAperture.ManagerApi used for connection.

  The `request` option defines the MessagingRpcRequest map.

  The `id` option defines the MessagingRpcRequest id.

  The `queryparams` option defines the query parameters (optional).

  The `headers` option defines the header values (optional).

  The `options` option defines any extra HTTP options (optional).

  ## Return Values

  Integer of new request, or nil
  """
  @spec update_request!(pid, String.t, map, map, list, list) :: term | nil
  def update_request!(api \\ ManagerApi.get_api, id, request, queryparams \\ %{}, headers \\ [], options \\ []) do
    response = update_request(api, id, request, queryparams, headers, options)
    if response.success? do
      Response.extract_identifier_from_location_header(response)
    else
      nil
    end
  end

  @doc """
  Delete a MessagingRpcRequest.

  ## Options
  The `api` option defines the OpenAperture.ManagerApi used for connection.

  The `id` option defines the MessagingRpcRequest id.

  The `queryparams` option defines the query parameters (optional).

  The `headers` option defines the header values (optional).

  The `options` option defines any extra HTTP options (optional).

  ## Return Values

  Returns the OpenAperture.ManagerApi.Response struct.
  """
  @spec delete_request(pid, String.t, map, list, list) :: term
  def delete_request(api \\ ManagerApi.get_api, id, queryparams \\ %{}, headers \\ [], options \\ []) do
    delete(api, get_path("messaging/rpc_requests/#{id}", queryparams), headers, options)
  end

  @doc """
  Delete a MessagingRpcRequest.

  ## Options
  The `api` option defines the OpenAperture.ManagerApi used for connection.

  The `id` option defines the MessagingRpcRequest id.

  The `queryparams` option defines the query parameters (optional).

  The `headers` option defines the header values (optional).

  The `options` option defines any extra HTTP options (optional).

  ## Return Values

  Boolean
  """
  @spec delete_request!(pid, String.t,  map, list, list) :: term
  def delete_request!(api \\ ManagerApi.get_api, id, queryparams \\ %{}, headers \\ [], options \\ []) do
    delete_request(api, id, queryparams, headers, options).success?
  end
end