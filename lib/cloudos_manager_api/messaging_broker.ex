#
# == messaging_broker.ex
#
# This module contains the resources for managing MessagingBrokers
#
defmodule CloudOS.ManagerAPI.MessagingBroker do
  import CloudOS.ManagerAPI.Resource

  alias CloudOS.ManagerAPI

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
end