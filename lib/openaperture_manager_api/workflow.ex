#
# == workflow.ex
#
# This module contains the resources for managing Workflows
#
defmodule OpenAperture.ManagerApi.Workflow do
  import OpenAperture.ManagerApi.Resource

  alias OpenAperture.ManagerApi
  alias OpenAperture.ManagerApi.Response

  @moduledoc """
  This module contains the resources for managing Workflows
  """  

  @doc """
  Retrieves the entire list of Workflows. 

  ## Options
  The `api` option defines the OpenAperture.ManagerApi used for connection.

  The `queryparams` option defines the query parameters (optional).

  The `headers` option defines the header values (optional).

  The `options` option defines any extra HTTP options (optional).

  ## Return Values

  Returns the OpenAperture.ManagerApi.Response struct.
  """
  @spec list(pid, Map, List, List) :: term
  def list(api \\ ManagerApi.get_api, queryparams \\ %{}, headers \\ [], options \\ []) do
    get(api, get_path("workflows", queryparams), headers, options)
  end

  @doc """
  Retrieves the entire list of Workflows. 

  ## Options
  The `api` option defines the OpenAperture.ManagerApi used for connection.

  The `queryparams` option defines the query parameters (optional).

  The `headers` option defines the header values (optional).

  The `options` option defines any extra HTTP options (optional).

  ## Return Values

  Returns nil (if failure) or a list of Maps, each representing a Workflow.
  """
  @spec list!(pid, Map, List, List) :: List[Map] | nil
  def list!(api \\ ManagerApi.get_api, queryparams \\ %{}, headers \\ [], options \\ []) do
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
  The `api` option defines the OpenAperture.ManagerApi used for connection.

  The `id` option defines the Workflow id.

  The `queryparams` option defines the query parameters (optional).

  The `headers` option defines the header values (optional).

  The `options` option defines any extra HTTP options (optional).

  ## Return Values

  Returns the OpenAperture.ManagerApi.Response struct.
  """
  @spec get_workflow(pid, term, Map, List, List) :: term
  def get_workflow(api \\ ManagerApi.get_api, id, queryparams \\ %{}, headers \\ [], options \\ []) do
    get(api, get_path("workflows/#{id}", queryparams), headers, options)
  end

  @doc """
  Retrieves a specific Workflow.

  ## Options
  The `api` option defines the OpenAperture.ManagerApi used for connection.

  The `id` option defines the Workflow id.

  The `queryparams` option defines the query parameters (optional).

  The `headers` option defines the header values (optional).

  The `options` option defines any extra HTTP options (optional).

  ## Return Values

  Map of the Workflow
  """
  @spec get_workflow!(pid, term, Map, List, List) :: Map | nil
  def get_workflow!(api \\ ManagerApi.get_api, id, queryparams \\ %{}, headers \\ [], options \\ []) do
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
  The `api` option defines the OpenAperture.ManagerApi used for connection.

  The `workflow` option defines the Workflow map.

  The `queryparams` option defines the query parameters (optional).

  The `headers` option defines the header values (optional).

  The `options` option defines any extra HTTP options (optional).

  ## Return Values

  Returns the OpenAperture.ManagerApi.Response struct.
  """
  @spec create_workflow(pid, Map, Map, List, List) :: term
  def create_workflow(api \\ ManagerApi.get_api, workflow, queryparams \\ %{}, headers \\ [], options \\ []) do
    post(api, get_path("workflows", queryparams), workflow, headers, options)
  end

  @doc """
  Create a Workflow.

  ## Options
  The `api` option defines the OpenAperture.ManagerApi used for connection.

  The `workflow` option defines the Workflow map.

  The `queryparams` option defines the query parameters (optional).

  The `headers` option defines the header values (optional).

  The `options` option defines any extra HTTP options (optional).

  ## Return Values

  Integer of new workflow, or nil
  """
  @spec create_workflow!(pid, Map, Map, List, List) :: term | nil
  def create_workflow!(api \\ ManagerApi.get_api, workflow, queryparams \\ %{}, headers \\ [], options \\ []) do
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
  The `api` option defines the OpenAperture.ManagerApi used for connection.

  The `workflow` option defines the Workflow map.

  The `id` option defines the Workflow id.

  The `queryparams` option defines the query parameters (optional).

  The `headers` option defines the header values (optional).

  The `options` option defines any extra HTTP options (optional).

  ## Return Values

  Returns the OpenAperture.ManagerApi.Response struct.
  """
  @spec update_workflow(pid, String.t, Map, Map, List, List) :: term
  def update_workflow(api \\ ManagerApi.get_api, id, workflow, queryparams \\ %{}, headers \\ [], options \\ []) do
    put(api, get_path("workflows/#{id}", queryparams), workflow, headers, options)
  end

  @doc """
  Update a Workflow.

  ## Options
  The `api` option defines the OpenAperture.ManagerApi used for connection.

  The `workflow` option defines the Workflow map.

  The `id` option defines the Workflow id.

  The `queryparams` option defines the query parameters (optional).

  The `headers` option defines the header values (optional).

  The `options` option defines any extra HTTP options (optional).

  ## Return Values

  Integer of new workflow, or nil
  """
  @spec update_workflow!(pid, String.t, Map, Map, List, List) :: term | nil
  def update_workflow!(api \\ ManagerApi.get_api, id, workflow, queryparams \\ %{}, headers \\ [], options \\ []) do
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
  The `api` option defines the OpenAperture.ManagerApi used for connection.

  The `id` option defines the Workflow id.

  The `queryparams` option defines the query parameters (optional).

  The `headers` option defines the header values (optional).

  The `options` option defines any extra HTTP options (optional).

  ## Return Values

  Returns the OpenAperture.ManagerApi.Response struct.
  """
  @spec delete_workflow(pid, String.t, Map, List, List) :: term
  def delete_workflow(api \\ ManagerApi.get_api, id, queryparams \\ %{}, headers \\ [], options \\ []) do
    delete(api, get_path("workflows/#{id}", queryparams), headers, options)
  end

  @doc """
  Delete a Workflow.

  ## Options
  The `api` option defines the OpenAperture.ManagerApi used for connection.

  The `id` option defines the Workflow id.

  The `queryparams` option defines the query parameters (optional).

  The `headers` option defines the header values (optional).

  The `options` option defines any extra HTTP options (optional).

  ## Return Values

  Boolean
  """
  @spec delete_workflow!(pid, String.t,  Map, List, List) :: term
  def delete_workflow!(api \\ ManagerApi.get_api, id, queryparams \\ %{}, headers \\ [], options \\ []) do
    delete_workflow(api, id, queryparams, headers, options).success?
  end

  @doc """
  Execute a Workflow.

  ## Options
  The `api` option defines the OpenAperture.ManagerApi used for connection.

  The `execute_options` option defines the execution options map.

  The `id` option defines the Workflow id.

  The `queryparams` option defines the query parameters (optional).

  The `headers` option defines the header values (optional).

  The `options` option defines any extra HTTP options (optional).

  ## Return Values

  Returns the OpenAperture.ManagerApi.Response struct.
  """
  @spec execute_workflow(pid, String.t, Map, Map, List, List) :: term
  def execute_workflow(api \\ ManagerApi.get_api, id, execute_options, queryparams \\ %{}, headers \\ [], options \\ []) do
    post(api, get_path("workflows/#{id}/execute", queryparams), execute_options, headers, options)
  end

  @doc """
  Execute a Workflow.

  ## Options
  The `api` option defines the OpenAperture.ManagerApi used for connection.

  The `execute_options` option defines the execution options map.

  The `id` option defines the Workflow id.

  The `queryparams` option defines the query parameters (optional).

  The `headers` option defines the header values (optional).

  The `options` option defines any extra HTTP options (optional).

  ## Return Values

  Boolean, if execution was successful
  """
  @spec execute_workflow!(pid, String.t, Map, Map, List, List) :: term
  def execute_workflow!(api \\ ManagerApi.get_api, id, execute_options, queryparams \\ %{}, headers \\ [], options \\ []) do
    response = execute_workflow(api, id, execute_options, queryparams, headers, options)
    response.success?
  end  
end