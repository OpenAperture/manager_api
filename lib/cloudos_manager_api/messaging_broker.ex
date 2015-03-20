#
# == messaging_broker.ex
#
# This module contains the resources for managing MessagingBrokers
#
defmodule CloudOS.ManagerAPI.MessagingBroker do
  import CloudOS.ManagerAPI.Resource

  alias CloudOS.ManagerAPI
  alias CloudOS.ManagerAPI.Response

  @moduledoc """
  This module contains the resources for managing MessagingBrokers
  """  

  @doc """
  Retrieves the entire list of MessagingBrokers. 

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
    get(api, get_path("messaging/brokers", queryparams), headers, options)
  end

  @doc """
  Retrieves the entire list of MessagingBrokers. 

  ## Options
  The `api` option defines the CloudOS.ManagerAPI used for connection.

  The `queryparams` option defines the query parameters (optional).

  The `headers` option defines the header values (optional).

  The `options` option defines any extra HTTP options (optional).

  ## Return Values

  Returns nil (if failure) or a list of Maps, each representing a MessagingBroker.
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
  Retrieves a specific MessagingBroker.

  ## Options
  The `api` option defines the CloudOS.ManagerAPI used for connection.

  The `id` option defines the MessagingBroker id.

  The `queryparams` option defines the query parameters (optional).

  The `headers` option defines the header values (optional).

  The `options` option defines any extra HTTP options (optional).

  ## Return Values

  Returns the CloudOS.ManagerAPI.Response struct.
  """
  @spec get_broker(pid, term, Map, List, List) :: term
  def get_broker(api \\ ManagerAPI.get_api, id, queryparams \\ %{}, headers \\ [], options \\ []) do
    get(api, get_path("messaging/brokers/#{id}", queryparams), headers, options)
  end

  @doc """
  Retrieves a specific MessagingBroker.

  ## Options
  The `api` option defines the CloudOS.ManagerAPI used for connection.

  The `id` option defines the MessagingBroker id.

  The `queryparams` option defines the query parameters (optional).

  The `headers` option defines the header values (optional).

  The `options` option defines any extra HTTP options (optional).

  ## Return Values

  Map of the MessagingBroker
  """
  @spec get_broker!(pid, term, Map, List, List) :: Map
  def get_broker!(api \\ ManagerAPI.get_api, id, queryparams \\ %{}, headers \\ [], options \\ []) do
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
  The `api` option defines the CloudOS.ManagerAPI used for connection.

  The `broker` option defines the MessagingBroker map.

  The `queryparams` option defines the query parameters (optional).

  The `headers` option defines the header values (optional).

  The `options` option defines any extra HTTP options (optional).

  ## Return Values

  Returns the CloudOS.ManagerAPI.Response struct.
  """
  @spec create_broker(pid, Map, Map, List, List) :: term
  def create_broker(api \\ ManagerAPI.get_api, broker, queryparams \\ %{}, headers \\ [], options \\ []) do
    post(api, get_path("messaging/brokers", queryparams), broker, headers, options)
  end

  @doc """
  Create a MessagingBroker.

  ## Options
  The `api` option defines the CloudOS.ManagerAPI used for connection.

  The `broker` option defines the MessagingBroker map.

  The `queryparams` option defines the query parameters (optional).

  The `headers` option defines the header values (optional).

  The `options` option defines any extra HTTP options (optional).

  ## Return Values

  Integer of new broker, or nil
  """
  @spec create_broker!(pid, Map, Map, List, List) :: term
  def create_broker!(api \\ ManagerAPI.get_api, broker, queryparams \\ %{}, headers \\ [], options \\ []) do
    response = post(api, get_path("messaging/brokers", queryparams), broker, headers, options)
    if response.success? do
      Response.extract_identifier_from_location_header(response)
    else
      nil
    end
  end  
end