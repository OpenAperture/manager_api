#
# == messaging_broker.ex
#
# This module contains the resources for managing MessagingBrokers
#
defmodule OpenAperture.ManagerApi.MessagingBroker do
  import OpenAperture.ManagerApi.Resource

  alias OpenAperture.ManagerApi
  alias OpenAperture.ManagerApi.Response

  @moduledoc """
  This module contains the resources for managing MessagingBrokers
  """

  @doc """
  Retrieves the entire list of MessagingBrokers.

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
    get(api, get_path("messaging/brokers", queryparams), headers, options)
  end

  @doc """
  Retrieves the entire list of MessagingBrokers.

  ## Options
  The `api` option defines the OpenAperture.ManagerApi used for connection.

  The `queryparams` option defines the query parameters (optional).

  The `headers` option defines the header values (optional).

  The `options` option defines any extra HTTP options (optional).

  ## Return Values

  Returns nil (if failure) or a list of Maps, each representing a MessagingBroker.
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
  Retrieves a specific MessagingBroker.

  ## Options
  The `api` option defines the OpenAperture.ManagerApi used for connection.

  The `id` option defines the MessagingBroker id.

  The `queryparams` option defines the query parameters (optional).

  The `headers` option defines the header values (optional).

  The `options` option defines any extra HTTP options (optional).

  ## Return Values

  Returns the OpenAperture.ManagerApi.Response struct.
  """
  @spec get_broker(pid, term, map, list, list) :: term
  def get_broker(api \\ ManagerApi.get_api, id, queryparams \\ %{}, headers \\ [], options \\ []) do
    get(api, get_path("messaging/brokers/#{id}", queryparams), headers, options)
  end

  @doc """
  Retrieves a specific MessagingBroker.

  ## Options
  The `api` option defines the OpenAperture.ManagerApi used for connection.

  The `id` option defines the MessagingBroker id.

  The `queryparams` option defines the query parameters (optional).

  The `headers` option defines the header values (optional).

  The `options` option defines any extra HTTP options (optional).

  ## Return Values

  Map of the MessagingBroker
  """
  @spec get_broker!(pid, term, map, list, list) :: map | nil
  def get_broker!(api \\ ManagerApi.get_api, id, queryparams \\ %{}, headers \\ [], options \\ []) do
    response = get_broker(api, id, queryparams, headers, options)
    if response.success? do
      response.body
    else
      nil
    end
  end

  @doc """
  Create a MessagingBroker.

  ## Options
  The `api` option defines the OpenAperture.ManagerApi used for connection.

  The `broker` option defines the MessagingBroker map.

  The `queryparams` option defines the query parameters (optional).

  The `headers` option defines the header values (optional).

  The `options` option defines any extra HTTP options (optional).

  ## Return Values

  Returns the OpenAperture.ManagerApi.Response struct.
  """
  @spec create_broker(pid, map, map, list, list) :: term
  def create_broker(api \\ ManagerApi.get_api, broker, queryparams \\ %{}, headers \\ [], options \\ []) do
    post(api, get_path("messaging/brokers", queryparams), broker, headers, options)
  end

  @doc """
  Create a MessagingBroker.

  ## Options
  The `api` option defines the OpenAperture.ManagerApi used for connection.

  The `broker` option defines the MessagingBroker map.

  The `queryparams` option defines the query parameters (optional).

  The `headers` option defines the header values (optional).

  The `options` option defines any extra HTTP options (optional).

  ## Return Values

  Integer of new broker, or nil
  """
  @spec create_broker!(pid, map, map, list, list) :: term | nil
  def create_broker!(api \\ ManagerApi.get_api, broker, queryparams \\ %{}, headers \\ [], options \\ []) do
    response = create_broker(api, broker, queryparams, headers, options)
    if response.success? do
      Response.extract_identifier_from_location_header(response)
    else
      nil
    end
  end

  @doc """
  Update a MessagingBroker.

  ## Options
  The `api` option defines the OpenAperture.ManagerApi used for connection.

  The `broker` option defines the MessagingBroker map.

  The `id` option defines the MessagingBroker id.

  The `queryparams` option defines the query parameters (optional).

  The `headers` option defines the header values (optional).

  The `options` option defines any extra HTTP options (optional).

  ## Return Values

  Returns the OpenAperture.ManagerApi.Response struct.
  """
  @spec update_broker(pid, String.t, map, map, list, list) :: term
  def update_broker(api \\ ManagerApi.get_api, id, broker, queryparams \\ %{}, headers \\ [], options \\ []) do
    put(api, get_path("messaging/brokers/#{id}", queryparams), broker, headers, options)
  end

  @doc """
  Update a MessagingBroker.

  ## Options
  The `api` option defines the OpenAperture.ManagerApi used for connection.

  The `broker` option defines the MessagingBroker map.

  The `id` option defines the MessagingBroker id.

  The `queryparams` option defines the query parameters (optional).

  The `headers` option defines the header values (optional).

  The `options` option defines any extra HTTP options (optional).

  ## Return Values

  Integer of new broker, or nil
  """
  @spec update_broker!(pid, String.t, map, map, list, list) :: term | nil
  def update_broker!(api \\ ManagerApi.get_api, id, broker, queryparams \\ %{}, headers \\ [], options \\ []) do
    response = update_broker(api, id, broker, queryparams, headers, options)
    if response.success? do
      Response.extract_identifier_from_location_header(response)
    else
      nil
    end
  end

  @doc """
  Delete a MessagingBroker.

  ## Options
  The `api` option defines the OpenAperture.ManagerApi used for connection.

  The `id` option defines the MessagingBroker id.

  The `queryparams` option defines the query parameters (optional).

  The `headers` option defines the header values (optional).

  The `options` option defines any extra HTTP options (optional).

  ## Return Values

  Returns the OpenAperture.ManagerApi.Response struct.
  """
  @spec delete_broker(pid, String.t, map, list, list) :: term
  def delete_broker(api \\ ManagerApi.get_api, id, queryparams \\ %{}, headers \\ [], options \\ []) do
    delete(api, get_path("messaging/brokers/#{id}", queryparams), headers, options)
  end

  @doc """
  Delete a MessagingBroker.

  ## Options
  The `api` option defines the OpenAperture.ManagerApi used for connection.

  The `id` option defines the MessagingBroker id.

  The `queryparams` option defines the query parameters (optional).

  The `headers` option defines the header values (optional).

  The `options` option defines any extra HTTP options (optional).

  ## Return Values

  Boolean
  """
  @spec delete_broker!(pid, String.t,  map, list, list) :: term
  def delete_broker!(api \\ ManagerApi.get_api, id, queryparams \\ %{}, headers \\ [], options \\ []) do
    delete_broker(api, id, queryparams, headers, options).success?
  end

  @doc """
  Create a MessagingBrokerConnection.

  ## Options
  The `api` option defines the OpenAperture.ManagerApi used for connection.

  The `id` option defines the MessagingBroker id.

  The `connection` option defines the MessagingBrokerConnection map.

  The `queryparams` option defines the query parameters (optional).

  The `headers` option defines the header values (optional).

  The `options` option defines any extra HTTP options (optional).

  ## Return Values

  Returns the OpenAperture.ManagerApi.Response struct.
  """
  @spec create_broker_connection(pid, String.t, map, map, list, list) :: term
  def create_broker_connection(api \\ ManagerApi.get_api, id, connection, queryparams \\ %{}, headers \\ [], options \\ []) do
    post(api, get_path("messaging/brokers/#{id}/connections", queryparams), connection, headers, options)
  end

  @doc """
  Create a MessagingBrokerConnection.

  ## Options
  The `api` option defines the OpenAperture.ManagerApi used for connection.

  The `id` option defines the MessagingBroker id.

  The `connection` option defines the MessagingBrokerConnection map.

  The `queryparams` option defines the query parameters (optional).

  The `headers` option defines the header values (optional).

  The `options` option defines any extra HTTP options (optional).

  ## Return Values

  Boolean
  """
  @spec create_broker_connection!(pid, String.t, map, map, list, list) :: term
  def create_broker_connection!(api \\ ManagerApi.get_api, id, connection, queryparams \\ %{}, headers \\ [], options \\ []) do
    create_broker_connection(api, id, connection, queryparams, headers, options).success?
  end

  @doc """
  Get MessagingBrokerConnections.

  ## Options
  The `api` option defines the OpenAperture.ManagerApi used for connection.

  The `id` option defines the MessagingBroker id.

  The `queryparams` option defines the query parameters (optional).

  The `headers` option defines the header values (optional).

  The `options` option defines any extra HTTP options (optional).

  ## Return Values

  Returns the OpenAperture.ManagerApi.Response struct.
  """
  @spec broker_connections(pid, String.t, List, List) :: term
  def broker_connections(api \\ ManagerApi.get_api, id, queryparams \\ %{}, headers \\ [], options \\ []) do
    get(api, get_path("messaging/brokers/#{id}/connections", queryparams), headers, options)
  end

  @doc """
  Get MessagingBrokerConnections.

  ## Options
  The `api` option defines the OpenAperture.ManagerApi used for connection.

  The `id` option defines the MessagingBroker id.

  The `queryparams` option defines the query parameters (optional).

  The `headers` option defines the header values (optional).

  The `options` option defines any extra HTTP options (optional).

  ## Return Values

  List or nil
  """
  @spec broker_connections!(pid, String.t, map, list, list) :: List | nil
  def broker_connections!(api \\ ManagerApi.get_api, id, queryparams \\ %{}, headers \\ [], options \\ []) do
    response = broker_connections(api, id, queryparams, headers, options)
    if response.success? do
      response.body
    else
      nil
    end
  end

  @doc """
  Delete MessagingBrokerConnections.

  ## Options
  The `api` option defines the OpenAperture.ManagerApi used for connection.

  The `id` option defines the MessagingBroker id.

  The `queryparams` option defines the query parameters (optional).

  The `headers` option defines the header values (optional).

  The `options` option defines any extra HTTP options (optional).

  ## Return Values

  Returns the OpenAperture.ManagerApi.Response struct.
  """
  @spec delete_broker_connections(pid, String.t, map, list, list) :: term
  def delete_broker_connections(api \\ ManagerApi.get_api, id, queryparams \\ %{}, headers \\ [], options \\ []) do
    delete(api, get_path("messaging/brokers/#{id}/connections", queryparams), headers, options)
  end

  @doc """
  Delete a MessagingBrokerConnections.

  ## Options
  The `api` option defines the OpenAperture.ManagerApi used for connection.

  The `id` option defines the MessagingBroker id.

  The `queryparams` option defines the query parameters (optional).

  The `headers` option defines the header values (optional).

  The `options` option defines any extra HTTP options (optional).

  ## Return Values

  Boolean
  """
  @spec delete_broker_connections!(pid, String.t,  map, list, list) :: term
  def delete_broker_connections!(api \\ ManagerApi.get_api, id, queryparams \\ %{}, headers \\ [], options \\ []) do
    delete_broker_connections(api, id, queryparams, headers, options).success?
  end
end