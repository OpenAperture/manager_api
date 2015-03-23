#
# == messaging_exchange.ex
#
# This module contains the resources for managing MessagingExchanges
#
defmodule CloudOS.ManagerAPI.MessagingExchange do
  import CloudOS.ManagerAPI.Resource

  alias CloudOS.ManagerAPI
  alias CloudOS.ManagerAPI.Response

  @moduledoc """
  This module contains the resources for managing MessagingExchanges
  """  

  @doc """
  Retrieves the entire list of MessagingExchanges. 

  ## Options
  The `api` option defines the CloudOS.ManagerAPI used for connection.

  The `queryparams` option defines the query parameters (optional).

  The `headers` option defines the header values (optional).

  The `options` option defines any extra HTTP options (optional).

  ## Return Values

  Returns the CloudOS.ManagerAPI.Response struct.
  """
  @spec list(pid, Map, List, List) :: term
  def list(api \\ ManagerAPI.get_api, queryparams \\ %{}, headers \\ [], options \\ []) do
    get(api, get_path("messaging/exchanges", queryparams), headers, options)
  end

  @doc """
  Retrieves the entire list of MessagingExchanges. 

  ## Options
  The `api` option defines the CloudOS.ManagerAPI used for connection.

  The `queryparams` option defines the query parameters (optional).

  The `headers` option defines the header values (optional).

  The `options` option defines any extra HTTP options (optional).

  ## Return Values

  Returns nil (if failure) or a list of Maps, each representing a MessagingExchanges.
  """
  @spec list(pid, Map, List, List) :: List[Map]
  def list!(api \\ ManagerAPI.get_api, queryparams \\ %{}, headers \\ [], options \\ []) do
    response = list(api, queryparams, headers, options)
    if response.success? do
      response.body
    else
      nil
    end
  end

  @doc """
  Retrieves a specific MessagingExchange.

  ## Options
  The `api` option defines the CloudOS.ManagerAPI used for connection.

  The `id` option defines the MessagingExchange id.

  The `queryparams` option defines the query parameters (optional).

  The `headers` option defines the header values (optional).

  The `options` option defines any extra HTTP options (optional).

  ## Return Values

  Returns the CloudOS.ManagerAPI.Response struct.
  """
  @spec get_exchange(pid, term, Map, List, List) :: term
  def get_exchange(api \\ ManagerAPI.get_api, id, queryparams \\ %{}, headers \\ [], options \\ []) do
    get(api, get_path("messaging/exchanges/#{id}", queryparams), headers, options)
  end

  @doc """
  Retrieves a specific MessagingExchange.

  ## Options
  The `api` option defines the CloudOS.ManagerAPI used for connection.

  The `id` option defines the MessagingExchange id.

  The `queryparams` option defines the query parameters (optional).

  The `headers` option defines the header values (optional).

  The `options` option defines any extra HTTP options (optional).

  ## Return Values

  Map of the MessagingExchange
  """
  @spec get_exchange!(pid, term, Map, List, List) :: Map
  def get_exchange!(api \\ ManagerAPI.get_api, id, queryparams \\ %{}, headers \\ [], options \\ []) do
    response = get_exchange(api, id, queryparams, headers, options)
    if response.success? do
      response.body
    else
      nil
    end
  end

  @doc """
  Create a MessagingExchange.

  ## Options
  The `api` option defines the CloudOS.ManagerAPI used for connection.

  The `exchange` option defines the MessagingExchange map.

  The `queryparams` option defines the query parameters (optional).

  The `headers` option defines the header values (optional).

  The `options` option defines any extra HTTP options (optional).

  ## Return Values

  Returns the CloudOS.ManagerAPI.Response struct.
  """
  @spec create_exchange(pid, Map, Map, List, List) :: term
  def create_exchange(api \\ ManagerAPI.get_api, exchange, queryparams \\ %{}, headers \\ [], options \\ []) do
    post(api, get_path("messaging/exchanges", queryparams), exchange, headers, options)
  end

  @doc """
  Create a MessagingExchange.

  ## Options
  The `api` option defines the CloudOS.ManagerAPI used for connection.

  The `exchange` option defines the MessagingExchange map.

  The `queryparams` option defines the query parameters (optional).

  The `headers` option defines the header values (optional).

  The `options` option defines any extra HTTP options (optional).

  ## Return Values

  Integer of new exchange, or nil
  """
  @spec create_exchange!(pid, Map, Map, List, List) :: term
  def create_exchange!(api \\ ManagerAPI.get_api, exchange, queryparams \\ %{}, headers \\ [], options \\ []) do
    response = create_exchange(api, exchange, queryparams, headers, options)
    if response.success? do
      Response.extract_identifier_from_location_header(response)
    else
      nil
    end
  end

  @doc """
  Update a MessagingExchange.

  ## Options
  The `api` option defines the CloudOS.ManagerAPI used for connection.

  The `exchange` option defines the MessagingExchange map.

  The `id` option defines the MessagingExchange id.

  The `queryparams` option defines the query parameters (optional).

  The `headers` option defines the header values (optional).

  The `options` option defines any extra HTTP options (optional).

  ## Return Values

  Returns the CloudOS.ManagerAPI.Response struct.
  """
  @spec update_exchange(pid, String.t(), Map, Map, List, List) :: term
  def update_exchange(api \\ ManagerAPI.get_api, id, broker, queryparams \\ %{}, headers \\ [], options \\ []) do
    put(api, get_path("messaging/exchanges/#{id}", queryparams), broker, headers, options)
  end

  @doc """
  Update a MessagingExchange.

  ## Options
  The `api` option defines the CloudOS.ManagerAPI used for connection.

  The `exchange` option defines the MessagingExchange map.

  The `id` option defines the MessagingExchange id.

  The `queryparams` option defines the query parameters (optional).

  The `headers` option defines the header values (optional).

  The `options` option defines any extra HTTP options (optional).

  ## Return Values

  Integer of new exchange, or nil
  """
  @spec update_exchange!(pid, String.t(), Map, Map, List, List) :: term
  def update_exchange!(api \\ ManagerAPI.get_api, id, exchange, queryparams \\ %{}, headers \\ [], options \\ []) do
    response = update_exchange(api, id, exchange, queryparams, headers, options)
    if response.success? do
      Response.extract_identifier_from_location_header(response)
    else
      nil
    end
  end



  @doc """
  Delete a MessagingExchange.

  ## Options
  The `api` option defines the CloudOS.ManagerAPI used for connection.

  The `id` option defines the MessagingExchange id.

  The `queryparams` option defines the query parameters (optional).

  The `headers` option defines the header values (optional).

  The `options` option defines any extra HTTP options (optional).

  ## Return Values

  Returns the CloudOS.ManagerAPI.Response struct.
  """
  @spec delete_exchange(pid, String.t(), Map, List, List) :: term
  def delete_exchange(api \\ ManagerAPI.get_api, id, queryparams \\ %{}, headers \\ [], options \\ []) do
    delete(api, get_path("messaging/exchanges/#{id}", queryparams), headers, options)
  end

  @doc """
  Delete a MessagingExchange.

  ## Options
  The `api` option defines the CloudOS.ManagerAPI used for connection.

  The `id` option defines the MessagingExchange id.

  The `queryparams` option defines the query parameters (optional).

  The `headers` option defines the header values (optional).

  The `options` option defines any extra HTTP options (optional).

  ## Return Values

  Boolean
  """
  @spec delete_exchange!(pid, String.t(),  Map, List, List) :: term
  def delete_exchange!(api \\ ManagerAPI.get_api, id, queryparams \\ %{}, headers \\ [], options \\ []) do
    delete_exchange(api, id, queryparams, headers, options).success?
  end

  @doc """
  Create a MessagingExchangeBrokers.

  ## Options
  The `api` option defines the CloudOS.ManagerAPI used for connection.

  The `id` option defines the MessagingExchange id.

  The `connection` option defines the MessagingExchangeBrokers map.

  The `queryparams` option defines the query parameters (optional).

  The `headers` option defines the header values (optional).

  The `options` option defines any extra HTTP options (optional).

  ## Return Values

  Returns the CloudOS.ManagerAPI.Response struct.
  """
  @spec create_exchange_brokers(pid, String.t(), Map, Map, List, List) :: term
  def create_exchange_brokers(api \\ ManagerAPI.get_api, id, connection, queryparams \\ %{}, headers \\ [], options \\ []) do
    post(api, get_path("messaging/exchanges/#{id}/brokers", queryparams), connection, headers, options)
  end

  @doc """
  Create a MessagingExchangeBroker.

  ## Options
  The `api` option defines the CloudOS.ManagerAPI used for connection.

  The `id` option defines the MessagingExchange id.

  The `connection` option defines the MessagingExchangeBrokers map.

  The `queryparams` option defines the query parameters (optional).

  The `headers` option defines the header values (optional).

  The `options` option defines any extra HTTP options (optional).

  ## Return Values

  Boolean
  """
  @spec create_exchange_brokers!(pid, String.t(), Map, Map, List, List) :: term
  def create_exchange_brokers!(api \\ ManagerAPI.get_api, id, connection, queryparams \\ %{}, headers \\ [], options \\ []) do
    create_exchange_brokers(api, id, connection, queryparams, headers, options).success?
  end

  @doc """
  Get MessagingExchangeBrokers.

  ## Options
  The `api` option defines the CloudOS.ManagerAPI used for connection.

  The `id` option defines the MessagingExchange id.

  The `queryparams` option defines the query parameters (optional).

  The `headers` option defines the header values (optional).

  The `options` option defines any extra HTTP options (optional).

  ## Return Values

  Returns the CloudOS.ManagerAPI.Response struct.
  """
  @spec exchange_brokers(pid, String.t(), List, List) :: term
  def exchange_brokers(api \\ ManagerAPI.get_api, id, queryparams \\ %{}, headers \\ [], options \\ []) do
    get(api, get_path("messaging/exchanges/#{id}/brokers", queryparams), headers, options)
  end

  @doc """
  Get MessagingExchangeBrokers.

  ## Options
  The `api` option defines the CloudOS.ManagerAPI used for connection.

  The `id` option defines the MessagingExchange id.

  The `queryparams` option defines the query parameters (optional).

  The `headers` option defines the header values (optional).

  The `options` option defines any extra HTTP options (optional).

  ## Return Values

  List or nil
  """
  @spec exchange_brokers!(pid, String.t(), Map, List, List) :: List
  def exchange_brokers!(api \\ ManagerAPI.get_api, id, queryparams \\ %{}, headers \\ [], options \\ []) do
    response = exchange_brokers(api, id, queryparams, headers, options)
    if response.success? do
      response.body
    else
      nil
    end
  end

  @doc """
  Delete MessagingExchangeBrokers.

  ## Options
  The `api` option defines the CloudOS.ManagerAPI used for connection.

  The `id` option defines the MessagingExchange id.

  The `queryparams` option defines the query parameters (optional).

  The `headers` option defines the header values (optional).

  The `options` option defines any extra HTTP options (optional).

  ## Return Values

  Returns the CloudOS.ManagerAPI.Response struct.
  """
  @spec delete_exchange_brokers(pid, String.t(), Map, List, List) :: term
  def delete_exchange_brokers(api \\ ManagerAPI.get_api, id, queryparams \\ %{}, headers \\ [], options \\ []) do
    delete(api, get_path("messaging/exchanges/#{id}/brokers", queryparams), headers, options)
  end

  @doc """
  Delete a MessagingExchangeBrokers.

  ## Options
  The `api` option defines the CloudOS.ManagerAPI used for connection.

  The `id` option defines the MessagingExchange id.

  The `queryparams` option defines the query parameters (optional).

  The `headers` option defines the header values (optional).

  The `options` option defines any extra HTTP options (optional).

  ## Return Values

  Boolean
  """
  @spec delete_exchange_brokers!(pid, String.t(),  Map, List, List) :: term
  def delete_exchange_brokers!(api \\ ManagerAPI.get_api, id, queryparams \\ %{}, headers \\ [], options \\ []) do
    delete_exchange_brokers(api, id, queryparams, headers, options).success?
  end

  @doc """
  Get EtcdClusters associated with the MessagingExchange.

  ## Options
  The `api` option defines the CloudOS.ManagerAPI used for connection.

  The `id` option defines the MessagingExchange id.

  The `queryparams` option defines the query parameters (optional).

  The `headers` option defines the header values (optional).

  The `options` option defines any extra HTTP options (optional).

  ## Return Values

  Returns the CloudOS.ManagerAPI.Response struct.
  """
  @spec exchange_clusters(pid, String.t(), List, List) :: term
  def exchange_clusters(api \\ ManagerAPI.get_api, id, queryparams \\ %{}, headers \\ [], options \\ []) do
    get(api, get_path("messaging/exchanges/#{id}/clusters", queryparams), headers, options)
  end

  @doc """
  Get EtcdClusters associated with the MessagingExchange.

  ## Options
  The `api` option defines the CloudOS.ManagerAPI used for connection.

  The `id` option defines the MessagingExchange id.

  The `queryparams` option defines the query parameters (optional).

  The `headers` option defines the header values (optional).

  The `options` option defines any extra HTTP options (optional).

  ## Return Values

  List or nil
  """
  @spec exchange_clusters!(pid, String.t(), Map, List, List) :: List
  def exchange_clusters!(api \\ ManagerAPI.get_api, id, queryparams \\ %{}, headers \\ [], options \\ []) do
    response = exchange_clusters(api, id, queryparams, headers, options)
    if response.success? do
      response.body
    else
      nil
    end
  end
end