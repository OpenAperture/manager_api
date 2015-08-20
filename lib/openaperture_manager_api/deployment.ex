#
# == deployment.ex
#
# This module contains the resources for managing deployments
#
defmodule OpenAperture.ManagerApi.Deployment do
  import OpenAperture.ManagerApi.Resource

  alias OpenAperture.ManagerApi
  alias OpenAperture.ManagerApi.Response

  @moduledoc """
  This module contains the resources for managing deployments
  """

  @doc """
  Retrieves the entire list of deployments.

  ## Options
  The `api` option defines the OpenAperture.ManagerApi used for connection.

  The `queryparams` option defines the query parameters (optional).

  The `headers` option defines the header values (optional).

  The `options` option defines any extra HTTP options (optional).

  ## Return Values

  Returns the OpenAperture.ManagerApi.Response struct.
  """
  @spec list(pid, String.t, map, list, list) :: Response.t
  def list(api \\ ManagerApi.get_api, product_name, queryparams \\ %{}, headers \\ [], options \\ []) do
    get(api, get_path("products/#{product_name}/deployments", queryparams), headers, options)
  end

  @doc """
  Retrieves the entire list of deployments.

  ## Options
  The `api` option defines the OpenAperture.ManagerApi used for connection.

  The `queryparams` option defines the query parameters (optional).

  The `headers` option defines the header values (optional).

  The `options` option defines any extra HTTP options (optional).

  ## Return Values

  Returns nil (if failure) or a list of Maps, each representing a deployment.
  """
  @spec list!(pid, String.t, map, list, list) :: list[map] | nil
  def list!(api \\ ManagerApi.get_api, product_name, queryparams \\ %{}, headers \\ [], options \\ []) do
    response = list(api, product_name, queryparams, headers, options)
    if response.success? do
      response.body
    else
      nil
    end
  end

  @doc """
  Retrieves a specific deployment.

  ## Options
  The `api` option defines the OpenAperture.ManagerApi used for connection.

  The `id` option defines the deployment id.

  The `queryparams` option defines the query parameters (optional).

  The `headers` option defines the header values (optional).

  The `options` option defines any extra HTTP options (optional).

  ## Return Values

  Returns the OpenAperture.ManagerApi.Response struct.
  """
  @spec get_deployment(pid, term, map, list, list) :: term
  def get_deployment(api \\ ManagerApi.get_api, product_name, id, queryparams \\ %{}, headers \\ [], options \\ []) do
    get(api, get_path("products/#{product_name}/deployments/#{id}", queryparams), headers, options)
  end

  @doc """
  Retrieves a specific deployment.

  ## Options
  The `api` option defines the OpenAperture.ManagerApi used for connection.

  The `id` option defines the deployment id.

  The `queryparams` option defines the query parameters (optional).

  The `headers` option defines the header values (optional).

  The `options` option defines any extra HTTP options (optional).

  ## Return Values

  Map of the deployment
  """
  @spec get_deployment!(pid, term, map, list, list) :: map | nil
  def get_deployment!(api \\ ManagerApi.get_api, product_name, id, queryparams \\ %{}, headers \\ [], options \\ []) do
    response = get_deployment(api, product_name, id, queryparams, headers, options)
    if response.success? do
      response.body
    else
      nil
    end
  end

  @doc """
  Create a deployment.

  ## Options
  The `api` option defines the OpenAperture.ManagerApi used for connection.

  The `deployment` option defines the deployment map.

  The `queryparams` option defines the query parameters (optional).

  The `headers` option defines the header values (optional).

  The `options` option defines any extra HTTP options (optional).

  ## Return Values

  Returns the OpenAperture.ManagerApi.Response struct.
  """
  @spec create_deployment(pid, map, map, list, list) :: term
  def create_deployment(api \\ ManagerApi.get_api, product_name, deployment, queryparams \\ %{}, headers \\ [], options \\ []) do
    post(api, get_path("products/#{product_name}/deployments/", queryparams), deployment, headers, options)
  end

  @doc """
  Create a deployment.

  ## Options
  The `api` option defines the OpenAperture.ManagerApi used for connection.

  The `deployment` option defines the deployment map.

  The `queryparams` option defines the query parameters (optional).

  The `headers` option defines the header values (optional).

  The `options` option defines any extra HTTP options (optional).

  ## Return Values

  Integer of new deployment, or nil
  """
  @spec create_deployment!(pid, map, map, list, list) :: term | nil
  def create_deployment!(api \\ ManagerApi.get_api, product_name, deployment, queryparams \\ %{}, headers \\ [], options \\ []) do
    response = create_deployment(api, product_name, deployment, queryparams, headers, options)
    if response.success? do
      Response.extract_identifier_from_location_header(response)
    else
      nil
    end
  end

  @doc """
  Update a deployment.

  ## Options
  The `api` option defines the OpenAperture.ManagerApi used for connection.

  The `deployment` option defines the deployment map.

  The `id` option defines the deployment id.

  The `queryparams` option defines the query parameters (optional).

  The `headers` option defines the header values (optional).

  The `options` option defines any extra HTTP options (optional).

  ## Return Values

  Returns the OpenAperture.ManagerApi.Response struct.
  """
  @spec update_deployment(pid, String.t, map, map, list, list) :: term
  def update_deployment(api \\ ManagerApi.get_api, product_name, id, deployment, queryparams \\ %{}, headers \\ [], options \\ []) do
    put(api, get_path("products/#{product_name}/deployments/#{id}", queryparams), deployment, headers, options)
  end

  @doc """
  Update a deployment.

  ## Options
  The `api` option defines the OpenAperture.ManagerApi used for connection.

  The `deployment` option defines the deployment map.

  The `id` option defines the deployment id.

  The `queryparams` option defines the query parameters (optional).

  The `headers` option defines the header values (optional).

  The `options` option defines any extra HTTP options (optional).

  ## Return Values

  Integer of new deployment, or nil
  """
  @spec update_deployment!(pid, String.t, map, map, list, list) :: term | nil
  def update_deployment!(api \\ ManagerApi.get_api, product_name, id, deployment, queryparams \\ %{}, headers \\ [], options \\ []) do
    response = update_deployment(api, product_name, id, deployment, queryparams, headers, options)
    if response.success? do
      Response.extract_identifier_from_location_header(response)
    else
      nil
    end
  end

  @doc """
  Delete a deployment.

  ## Options
  The `api` option defines the OpenAperture.ManagerApi used for connection.

  The `id` option defines the deployment id.

  The `queryparams` option defines the query parameters (optional).

  The `headers` option defines the header values (optional).

  The `options` option defines any extra HTTP options (optional).

  ## Return Values

  Returns the OpenAperture.ManagerApi.Response struct.
  """
  @spec delete_deployment(pid, String.t, map, list, list) :: term
  def delete_deployment(api \\ ManagerApi.get_api, product_name, id, queryparams \\ %{}, headers \\ [], options \\ []) do
    delete(api, get_path("products/#{product_name}/deployments/#{id}", queryparams), headers, options)
  end

  @doc """
  Delete a deployment.

  ## Options
  The `api` option defines the OpenAperture.ManagerApi used for connection.

  The `id` option defines the deployment id.

  The `queryparams` option defines the query parameters (optional).

  The `headers` option defines the header values (optional).

  The `options` option defines any extra HTTP options (optional).

  ## Return Values

  Boolean
  """
  def delete_deployment!(api \\ ManagerApi.get_api, product_name, id, queryparams \\ %{}, headers \\ [], options \\ []) do
    delete_deployment(api, product_name, id, queryparams, headers, options).success?
  end

  @doc """
  Execute a deployment.

  ## Options
  The `api` option defines the OpenAperture.ManagerApi used for connection.

  The `execute_options` option defines the execution options map.

  The `id` option defines the deployment id.

  The `queryparams` option defines the query parameters (optional).

  The `headers` option defines the header values (optional).

  The `options` option defines any extra HTTP options (optional).

  ## Return Values

  Returns the OpenAperture.ManagerApi.Response struct.
  """
  def execute_deployment(api \\ ManagerApi.get_api, product_name, id, queryparams \\ %{}, headers \\ [], options \\ []) do
    post(api, get_path("products/#{product_name}/deployments/#{id}/execute", queryparams), %{}, headers, options)
  end

  @doc """
  Execute a deployment.

  ## Options
  The `api` option defines the OpenAperture.ManagerApi used for connection.

  The `execute_options` option defines the execution options map.

  The `id` option defines the deployment id.

  The `queryparams` option defines the query parameters (optional).

  The `headers` option defines the header values (optional).

  The `options` option defines any extra HTTP options (optional).

  ## Return Values

  Boolean, if execution was successful
  """
  @spec execute_deployment!(pid, String.t, map, map, list, list) :: term
  def execute_deployment!(api \\ ManagerApi.get_api, product_name, id, queryparams \\ %{}, headers \\ [], options \\ []) do
    response = execute_deployment(api, product_name, id, queryparams, headers, options)
    response.success?
  end
end