#
# == messaging_broker.ex
#
# This module contains the resources for managing EtcdClusters
#
defmodule CloudOS.ManagerAPI.EtcdCluster do
  import CloudOS.ManagerAPI.Resource

  alias CloudOS.ManagerAPI
  alias CloudOS.ManagerAPI.Response

  @moduledoc """
  This module contains the resources for managing EtcdClusters
  """  

  @doc """
  Retrieves the entire list of EtcdClusters. 

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
    get(api, get_path("clusters", queryparams), headers, options)
  end

  @doc """
  Retrieves the entire list of EtcdClusters. 

  ## Options
  The `api` option defines the CloudOS.ManagerAPI used for connection.

  The `queryparams` option defines the query parameters (optional).

  The `headers` option defines the header values (optional).

  The `options` option defines any extra HTTP options (optional).

  ## Return Values

  Returns nil (if failure) or a list of Maps, each representing an EtcdCluster.
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
  Retrieves a specific EtcdCluster.

  ## Options
  The `api` option defines the CloudOS.ManagerAPI used for connection.

  The `token` option defines the EtcdCluster token.

  The `queryparams` option defines the query parameters (optional).

  The `headers` option defines the header values (optional).

  The `options` option defines any extra HTTP options (optional).

  ## Return Values

  Returns the CloudOS.ManagerAPI.Response struct.
  """
  @spec get_cluster(pid, term, Map, List, List) :: term
  def get_cluster(api \\ ManagerAPI.get_api, token, queryparams \\ %{}, headers \\ [], options \\ []) do
    get(api, get_path("clusters/#{token}", queryparams), headers, options)
  end

  @doc """
  Retrieves a specific EtcdCluster.

  ## Options
  The `api` option defines the CloudOS.ManagerAPI used for connection.

  The `token` option defines the EtcdCluster token.

  The `queryparams` option defines the query parameters (optional).

  The `headers` option defines the header values (optional).

  The `options` option defines any extra HTTP options (optional).

  ## Return Values

  Map of the EtcdCluster
  """
  @spec get_cluster!(pid, term, Map, List, List) :: Map
  def get_cluster!(api \\ ManagerAPI.get_api, token, queryparams \\ %{}, headers \\ [], options \\ []) do
    response = get_cluster(api, token, queryparams, headers, options)
    if response.success? do
      response.body
    else
      nil
    end
  end

  @doc """
  Create a EtcdCluster.

  ## Options
  The `api` option defines the CloudOS.ManagerAPI used for connection.

  The `cluster` option defines the EtcdCluster map.

  The `queryparams` option defines the query parameters (optional).

  The `headers` option defines the header values (optional).

  The `options` option defines any extra HTTP options (optional).

  ## Return Values

  Returns the CloudOS.ManagerAPI.Response struct.
  """
  @spec create_cluster(pid, Map, Map, List, List) :: term
  def create_cluster(api \\ ManagerAPI.get_api, cluster, queryparams \\ %{}, headers \\ [], options \\ []) do
    post(api, get_path("clusters", queryparams), cluster, headers, options)
  end

  @doc """
  Create a EtcdCluster.

  ## Options
  The `api` option defines the CloudOS.ManagerAPI used for connection.

  The `cluster` option defines the EtcdCluster map.

  The `queryparams` option defines the query parameters (optional).

  The `headers` option defines the header values (optional).

  The `options` option defines any extra HTTP options (optional).

  ## Return Values

  Integer of new cluster, or nil
  """
  @spec create_cluster!(pid, Map, Map, List, List) :: term
  def create_cluster!(api \\ ManagerAPI.get_api, cluster, queryparams \\ %{}, headers \\ [], options \\ []) do
    response = create_cluster(api, cluster, queryparams, headers, options)
    if response.success? do
      Response.extract_identifier_from_location_header(response)
    else
      nil
    end
  end

  @doc """
  Delete a EtcdCluster.

  ## Options
  The `api` option defines the CloudOS.ManagerAPI used for connection.

  The `token` option defines the EtcdCluster token.

  The `queryparams` option defines the query parameters (optional).

  The `headers` option defines the header values (optional).

  The `options` option defines any extra HTTP options (optional).

  ## Return Values

  Returns the CloudOS.ManagerAPI.Response struct.
  """
  @spec delete_cluster(pid, String.t(), Map, List, List) :: term
  def delete_cluster(api \\ ManagerAPI.get_api, token, queryparams \\ %{}, headers \\ [], options \\ []) do
    delete(api, get_path("clusters/#{token}", queryparams), headers, options)
  end

  @doc """
  Delete a EtcdCluster.

  ## Options
  The `api` option defines the CloudOS.ManagerAPI used for connection.

  The `token` option defines the EtcdCluster token.

  The `queryparams` option defines the query parameters (optional).

  The `headers` option defines the header values (optional).

  The `options` option defines any extra HTTP options (optional).

  ## Return Values

  Boolean
  """
  @spec delete_cluster!(pid, String.t(),  Map, List, List) :: term
  def delete_cluster!(api \\ ManagerAPI.get_api, token, queryparams \\ %{}, headers \\ [], options \\ []) do
    delete_cluster(api, token, queryparams, headers, options).success?
  end

  @doc """
  Retrieves products associated with an EtcdCluster.

  ## Options
  The `api` option defines the CloudOS.ManagerAPI used for connection.

  The `token` option defines the EtcdCluster token.

  The `queryparams` option defines the query parameters (optional).

  The `headers` option defines the header values (optional).

  The `options` option defines any extra HTTP options (optional).

  ## Return Values

  Returns the CloudOS.ManagerAPI.Response struct.
  """
  @spec get_cluster_products(pid, term, Map, List, List) :: term
  def get_cluster_products(api \\ ManagerAPI.get_api, token, queryparams \\ %{}, headers \\ [], options \\ []) do
    get(api, get_path("clusters/#{token}/products", queryparams), headers, options)
  end

  @doc """
  Retrieves products associated with an EtcdCluster.

  ## Options
  The `api` option defines the CloudOS.ManagerAPI used for connection.

  The `token` option defines the EtcdCluster token.

  The `queryparams` option defines the query parameters (optional).

  The `headers` option defines the header values (optional).

  The `options` option defines any extra HTTP options (optional).

  ## Return Values

  Map of the EtcdCluster
  """
  @spec get_cluster_products!(pid, term, Map, List, List) :: Map
  def get_cluster_products!(api \\ ManagerAPI.get_api, token, queryparams \\ %{}, headers \\ [], options \\ []) do
    response = get_cluster_products(api, token, queryparams, headers, options)
    if response.success? do
      response.body
    else
      nil
    end
  end

  @doc """
  Retrieves machines associated with an EtcdCluster.

  ## Options
  The `api` option defines the CloudOS.ManagerAPI used for connection.

  The `token` option defines the EtcdCluster token.

  The `queryparams` option defines the query parameters (optional).

  The `headers` option defines the header values (optional).

  The `options` option defines any extra HTTP options (optional).

  ## Return Values

  Returns the CloudOS.ManagerAPI.Response struct.
  """
  @spec get_cluster_machines(pid, term, Map, List, List) :: term
  def get_cluster_machines(api \\ ManagerAPI.get_api, token, queryparams \\ %{}, headers \\ [], options \\ []) do
    get(api, get_path("clusters/#{token}/machines", queryparams), headers, options)
  end

  @doc """
  Retrieves machines associated with an EtcdCluster.

  ## Options
  The `api` option defines the CloudOS.ManagerAPI used for connection.

  The `token` option defines the EtcdCluster token.

  The `queryparams` option defines the query parameters (optional).

  The `headers` option defines the header values (optional).

  The `options` option defines any extra HTTP options (optional).

  ## Return Values

  Map of the EtcdCluster
  """
  @spec get_cluster_machines!(pid, term, Map, List, List) :: Map
  def get_cluster_machines!(api \\ ManagerAPI.get_api, token, queryparams \\ %{}, headers \\ [], options \\ []) do
    response = get_cluster_machines(api, token, queryparams, headers, options)
    if response.success? do
      response.body
    else
      nil
    end
  end

  @doc """
  Retrieves units associated with an EtcdCluster.

  ## Options
  The `api` option defines the CloudOS.ManagerAPI used for connection.

  The `token` option defines the EtcdCluster token.

  The `queryparams` option defines the query parameters (optional).

  The `headers` option defines the header values (optional).

  The `options` option defines any extra HTTP options (optional).

  ## Return Values

  Returns the CloudOS.ManagerAPI.Response struct.
  """
  @spec get_cluster_units(pid, term, Map, List, List) :: term
  def get_cluster_units(api \\ ManagerAPI.get_api, token, queryparams \\ %{}, headers \\ [], options \\ []) do
    get(api, get_path("clusters/#{token}/units", queryparams), headers, options)
  end

  @doc """
  Retrieves units associated with an EtcdCluster.

  ## Options
  The `api` option defines the CloudOS.ManagerAPI used for connection.

  The `token` option defines the EtcdCluster token.

  The `queryparams` option defines the query parameters (optional).

  The `headers` option defines the header values (optional).

  The `options` option defines any extra HTTP options (optional).

  ## Return Values

  Map of the EtcdCluster
  """
  @spec get_cluster_units!(pid, term, Map, List, List) :: Map
  def get_cluster_units!(api \\ ManagerAPI.get_api, token, queryparams \\ %{}, headers \\ [], options \\ []) do
    response = get_cluster_units(api, token, queryparams, headers, options)
    if response.success? do
      response.body
    else
      nil
    end
  end

  @doc """
  Retrieves units associated with an EtcdCluster.

  ## Options
  The `api` option defines the CloudOS.ManagerAPI used for connection.

  The `token` option defines the EtcdCluster token.

  The `queryparams` option defines the query parameters (optional).

  The `headers` option defines the header values (optional).

  The `options` option defines any extra HTTP options (optional).

  ## Return Values

  Returns the CloudOS.ManagerAPI.Response struct.
  """
  @spec get_cluster_units_state(pid, term, Map, List, List) :: term
  def get_cluster_units_state(api \\ ManagerAPI.get_api, token, queryparams \\ %{}, headers \\ [], options \\ []) do
    get(api, get_path("clusters/#{token}/state", queryparams), headers, options)
  end

  @doc """
  Retrieves unit state associated with an EtcdCluster.

  ## Options
  The `api` option defines the CloudOS.ManagerAPI used for connection.

  The `token` option defines the EtcdCluster token.

  The `queryparams` option defines the query parameters (optional).

  The `headers` option defines the header values (optional).

  The `options` option defines any extra HTTP options (optional).

  ## Return Values

  Map of the EtcdCluster
  """
  @spec get_cluster_units_state!(pid, term, Map, List, List) :: Map
  def get_cluster_units_state!(api \\ ManagerAPI.get_api, token, queryparams \\ %{}, headers \\ [], options \\ []) do
    response = get_cluster_units_state(api, token, queryparams, headers, options)
    if response.success? do
      response.body
    else
      nil
    end
  end

  @doc """
  Retrieves units associated with an EtcdCluster.

  ## Options
  The `api` option defines the CloudOS.ManagerAPI used for connection.

  The `token` option defines the EtcdCluster token.

  The `machine_id` option defines the EtcdCluster machine identifier.

  The `unit_name` option defines the EtcdCluster cluster unit name.

  The `queryparams` option defines the query parameters (optional).

  The `headers` option defines the header values (optional).

  The `options` option defines any extra HTTP options (optional).

  ## Return Values

  Returns the CloudOS.ManagerAPI.Response struct.
  """
  @spec get_cluster_units_state(pid, term, Map, List, List) :: term
  def get_cluster_unit_log(api \\ ManagerAPI.get_api, token, machine_id, unit_name, queryparams \\ %{}, headers \\ [], options \\ []) do
    get(api, get_path("clusters/#{token}/machines/#{machine_id}/units/#{unit_name}/logs", queryparams), headers, options)
  end

  @doc """
  Retrieves unit state associated with an EtcdCluster.

  ## Options
  The `api` option defines the CloudOS.ManagerAPI used for connection.

  The `token` option defines the EtcdCluster token.

  The `machine_id` option defines the EtcdCluster machine identifier.

  The `unit_name` option defines the EtcdCluster cluster unit name.

  The `queryparams` option defines the query parameters (optional).

  The `headers` option defines the header values (optional).

  The `options` option defines any extra HTTP options (optional).

  ## Return Values

  Map of the EtcdCluster
  """
  @spec get_cluster_unit_log!(pid, term, Map, List, List) :: Map
  def get_cluster_unit_log!(api \\ ManagerAPI.get_api, token, machine_id, unit_name, queryparams \\ %{}, headers \\ [], options \\ []) do
    response = get_cluster_unit_log(api, token, machine_id, unit_name, queryparams, headers, options)
    if response.success? do
      response.raw_body
    else
      nil
    end
  end
end