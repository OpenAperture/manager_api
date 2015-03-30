#
# == workflow.ex
#
# This module contains the resources for managing Workflows
#
defmodule CloudOS.ManagerAPI.Workflow do
  import CloudOS.ManagerAPI.Resource

  alias CloudOS.ManagerAPI
  alias CloudOS.ManagerAPI.Response

  @moduledoc """
  This module contains the resources for managing Workflows
  """  

  @doc """
  Retrieves the entire list of Workflows. 

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
    get(api, get_path("workflows", queryparams), headers, options)
  end

  @doc """
  Retrieves the entire list of Workflows. 

  ## Options
  The `api` option defines the CloudOS.ManagerAPI used for connection.

  The `queryparams` option defines the query parameters (optional).

  The `headers` option defines the header values (optional).

  The `options` option defines any extra HTTP options (optional).

  ## Return Values

  Returns nil (if failure) or a list of Maps, each representing a Workflow.
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
  Retrieves a specific Workflow.

  ## Options
  The `api` option defines the CloudOS.ManagerAPI used for connection.

  The `id` option defines the Workflow id.

  The `queryparams` option defines the query parameters (optional).

  The `headers` option defines the header values (optional).

  The `options` option defines any extra HTTP options (optional).

  ## Return Values

  Returns the CloudOS.ManagerAPI.Response struct.
  """
  @spec get_workflow(pid, term, Map, List, List) :: term
  def get_workflow(api \\ ManagerAPI.get_api, id, queryparams \\ %{}, headers \\ [], options \\ []) do
    get(api, get_path("workflows/#{id}", queryparams), headers, options)
  end

  @doc """
  Retrieves a specific Workflow.

  ## Options
  The `api` option defines the CloudOS.ManagerAPI used for connection.

  The `id` option defines the Workflow id.

  The `queryparams` option defines the query parameters (optional).

  The `headers` option defines the header values (optional).

  The `options` option defines any extra HTTP options (optional).

  ## Return Values

  Map of the Workflow
  """
  @spec get_workflow!(pid, term, Map, List, List) :: Map
  def get_workflow!(api \\ ManagerAPI.get_api, id, queryparams \\ %{}, headers \\ [], options \\ []) do
    response = get_workflow(api, id, queryparams, headers, options)
    if response.success? do
      response.body
    else
      nil
    end
  end

  @doc """
  Create a Workflow.

  ## Options
  The `api` option defines the CloudOS.ManagerAPI used for connection.

  The `workflow` option defines the Workflow map.

  The `queryparams` option defines the query parameters (optional).

  The `headers` option defines the header values (optional).

  The `options` option defines any extra HTTP options (optional).

  ## Return Values

  Returns the CloudOS.ManagerAPI.Response struct.
  """
  @spec create_workflow(pid, Map, Map, List, List) :: term
  def create_workflow(api \\ ManagerAPI.get_api, workflow, queryparams \\ %{}, headers \\ [], options \\ []) do
    post(api, get_path("workflows", queryparams), workflow, headers, options)
  end

  @doc """
  Create a Workflow.

  ## Options
  The `api` option defines the CloudOS.ManagerAPI used for connection.

  The `workflow` option defines the Workflow map.

  The `queryparams` option defines the query parameters (optional).

  The `headers` option defines the header values (optional).

  The `options` option defines any extra HTTP options (optional).

  ## Return Values

  Integer of new workflow, or nil
  """
  @spec create_workflow!(pid, Map, Map, List, List) :: term
  def create_workflow!(api \\ ManagerAPI.get_api, workflow, queryparams \\ %{}, headers \\ [], options \\ []) do
    response = create_workflow(api, workflow, queryparams, headers, options)
    if response.success? do
      Response.extract_identifier_from_location_header(response)
    else
      nil
    end
  end

  @doc """
  Update a Workflow.

  ## Options
  The `api` option defines the CloudOS.ManagerAPI used for connection.

  The `workflow` option defines the Workflow map.

  The `id` option defines the Workflow id.

  The `queryparams` option defines the query parameters (optional).

  The `headers` option defines the header values (optional).

  The `options` option defines any extra HTTP options (optional).

  ## Return Values

  Returns the CloudOS.ManagerAPI.Response struct.
  """
  @spec update_workflow(pid, String.t(), Map, Map, List, List) :: term
  def update_workflow(api \\ ManagerAPI.get_api, id, workflow, queryparams \\ %{}, headers \\ [], options \\ []) do
    put(api, get_path("workflows/#{id}", queryparams), workflow, headers, options)
  end

  @doc """
  Update a Workflow.

  ## Options
  The `api` option defines the CloudOS.ManagerAPI used for connection.

  The `workflow` option defines the Workflow map.

  The `id` option defines the Workflow id.

  The `queryparams` option defines the query parameters (optional).

  The `headers` option defines the header values (optional).

  The `options` option defines any extra HTTP options (optional).

  ## Return Values

  Integer of new workflow, or nil
  """
  @spec update_workflow!(pid, String.t(), Map, Map, List, List) :: term
  def update_workflow!(api \\ ManagerAPI.get_api, id, workflow, queryparams \\ %{}, headers \\ [], options \\ []) do
    response = update_workflow(api, id, workflow, queryparams, headers, options)
    if response.success? do
      Response.extract_identifier_from_location_header(response)
    else
      nil
    end
  end

  @doc """
  Delete a Workflow.

  ## Options
  The `api` option defines the CloudOS.ManagerAPI used for connection.

  The `id` option defines the Workflow id.

  The `queryparams` option defines the query parameters (optional).

  The `headers` option defines the header values (optional).

  The `options` option defines any extra HTTP options (optional).

  ## Return Values

  Returns the CloudOS.ManagerAPI.Response struct.
  """
  @spec delete_workflow(pid, String.t(), Map, List, List) :: term
  def delete_workflow(api \\ ManagerAPI.get_api, id, queryparams \\ %{}, headers \\ [], options \\ []) do
    delete(api, get_path("workflows/#{id}", queryparams), headers, options)
  end

  @doc """
  Delete a Workflow.

  ## Options
  The `api` option defines the CloudOS.ManagerAPI used for connection.

  The `id` option defines the Workflow id.

  The `queryparams` option defines the query parameters (optional).

  The `headers` option defines the header values (optional).

  The `options` option defines any extra HTTP options (optional).

  ## Return Values

  Boolean
  """
  @spec delete_workflow!(pid, String.t(),  Map, List, List) :: term
  def delete_workflow!(api \\ ManagerAPI.get_api, id, queryparams \\ %{}, headers \\ [], options \\ []) do
    delete_workflow(api, id, queryparams, headers, options).success?
  end
end