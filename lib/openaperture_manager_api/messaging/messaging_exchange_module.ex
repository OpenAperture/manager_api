#
# == messaging_exchange.ex
#
# This module contains the resources for managing MessagingExchangeModules
#
defmodule OpenAperture.ManagerApi.MessagingExchangeModule do
  import OpenAperture.ManagerApi.Resource

  alias OpenAperture.ManagerApi
  alias OpenAperture.ManagerApi.Response

  @moduledoc """
  This module contains the resources for managing MessagingExchangeModules
  """  

  @doc """
  Retrieves the entire list of MessagingExchangeModules. 

  ## Options
  The `api` option defines the OpenAperture.ManagerApi used for connection.

  The `exchange_id` option defines the MessagingExchange identifier

  The `queryparams` option defines the query parameters (optional).

  The `headers` option defines the header values (optional).

  The `options` option defines any extra HTTP options (optional).

  ## Return Values

  Returns the OpenAperture.ManagerApi.Response struct.
  """
  @spec list(pid, String.t, Map, List, List) :: term
  def list(api \\ ManagerApi.get_api, exchange_id, queryparams \\ %{}, headers \\ [], options \\ []) do
    get(api, get_path("messaging/exchanges/#{exchange_id}/modules", queryparams), headers, options)
  end

  @doc """
  Retrieves the entire list of MessagingExchanges. 

  ## Options
  The `api` option defines the OpenAperture.ManagerApi used for connection.

  The `exchange_id` option defines the MessagingExchange identifier

  The `queryparams` option defines the query parameters (optional).

  The `headers` option defines the header values (optional).

  The `options` option defines any extra HTTP options (optional).

  ## Return Values

  Returns nil (if failure) or a list of Maps, each representing a MessagingExchanges.
  """
  @spec list!(pid, String.t, Map, List, List) :: List[Map]
  def list!(api \\ ManagerApi.get_api, exchange_id, queryparams \\ %{}, headers \\ [], options \\ []) do
    response = list(api, exchange_id, queryparams, headers, options)
    if response.success? do
      response.body
    else
      nil
    end
  end

  @doc """
  Retrieves a specific MessagingExchangeModule.

  ## Options
  The `api` option defines the OpenAperture.ManagerApi used for connection.

  The `exchange_id` option defines the MessagingExchange identifier

  The `hostname` option defines the MessagingExchangeModule hostname

  The `queryparams` option defines the query parameters (optional).

  The `headers` option defines the header values (optional).

  The `options` option defines any extra HTTP options (optional).

  ## Return Values

  Returns the OpenAperture.ManagerApi.Response struct.
  """
  @spec get_module(pid, String.t, String.t, Map, List, List) :: term
  def get_module(api \\ ManagerApi.get_api, exchange_id, hostname, queryparams \\ %{}, headers \\ [], options \\ []) do
    get(api, get_path("messaging/exchanges/#{exchange_id}/modules/#{hostname}", queryparams), headers, options)
  end

  @doc """
  Retrieves a specific MessagingExchangeModule.

  ## Options
  The `api` option defines the OpenAperture.ManagerApi used for connection.

  The `exchange_id` option defines the MessagingExchange identifier

  The `hostname` option defines the MessagingExchangeModule hostname

  The `queryparams` option defines the query parameters (optional).

  The `headers` option defines the header values (optional).

  The `options` option defines any extra HTTP options (optional).

  ## Return Values

  Map of the MessagingExchange
  """
  @spec get_module!(pid, String.t, String.t, Map, List, List) :: Map
  def get_module!(api \\ ManagerApi.get_api, exchange_id, hostname, queryparams \\ %{}, headers \\ [], options \\ []) do
    response = get_module(api, exchange_id, hostname, queryparams, headers, options)
    if response.success? do
      response.body
    else
      nil
    end
  end  

  @doc """
  Create a MessagingExchangeModule.

  ## Options
  The `api` option defines the OpenAperture.ManagerApi used for connection.

  The `exchange_id` option defines the MessagingExchange identifier

  The `module` option defines the MessagingExchangeModule map

  The `queryparams` option defines the query parameters (optional).

  The `headers` option defines the header values (optional).

  The `options` option defines any extra HTTP options (optional).

  ## Return Values

  Returns the OpenAperture.ManagerApi.Response struct.
  """
  @spec create_module(pid, String.t, Map, Map, List, List) :: term
  def create_module(api \\ ManagerApi.get_api, exchange_id, module, queryparams \\ %{}, headers \\ [], options \\ []) do
    post(api, get_path("messaging/exchanges/#{exchange_id}/modules", queryparams), module, headers, options)
  end

  @doc """
  Create a MessagingExchange.

  ## Options
  The `api` option defines the OpenAperture.ManagerApi used for connection.

  The `exchange_id` option defines the MessagingExchange identifier

  The `module` option defines the MessagingExchangeModule map

  The `queryparams` option defines the query parameters (optional).

  The `headers` option defines the header values (optional).

  The `options` option defines any extra HTTP options (optional).

  ## Return Values

  Integer of new exchange, or nil
  """
  @spec create_module!(pid, String.t, Map, Map, List, List) :: term
  def create_module!(api \\ ManagerApi.get_api, exchange_id, module, queryparams \\ %{}, headers \\ [], options \\ []) do
    response = create_module(api, exchange_id, module, queryparams, headers, options)
    if response.success? do
      Response.extract_identifier_from_location_header(response)
    else
      nil
    end
  end

  @doc """
  Delete a MessagingExchangeModule.

  ## Options
  The `api` option defines the OpenAperture.ManagerApi used for connection.

  The `exchange_id` option defines the MessagingExchange identifier

  The `hostname` option defines the MessagingExchangeModule hostname

  The `queryparams` option defines the query parameters (optional).

  The `headers` option defines the header values (optional).

  The `options` option defines any extra HTTP options (optional).

  ## Return Values

  Returns the OpenAperture.ManagerApi.Response struct.
  """
  @spec delete_module(pid, String.t, String.t, Map, List, List) :: term
  def delete_module(api \\ ManagerApi.get_api, exchange_id, hostname, queryparams \\ %{}, headers \\ [], options \\ []) do
    delete(api, get_path("messaging/exchanges/#{exchange_id}/modules/#{hostname}", queryparams), headers, options)
  end

  @doc """
  Delete a MessagingExchangeModule.

  ## Options
  The `api` option defines the OpenAperture.ManagerApi used for connection.

  The `exchange_id` option defines the MessagingExchange identifier

  The `hostname` option defines the MessagingExchangeModule hostname

  The `queryparams` option defines the query parameters (optional).

  The `headers` option defines the header values (optional).

  The `options` option defines any extra HTTP options (optional).

  ## Return Values

  Boolean
  """
  @spec delete_module!(pid, String.t,  String.t, Map, List, List) :: term
  def delete_module!(api \\ ManagerApi.get_api, exchange_id, hostname, queryparams \\ %{}, headers \\ [], options \\ []) do
    delete_module(api, exchange_id, hostname, queryparams, headers, options).success?
  end  
end