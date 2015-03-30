#
# == resource.ex
#
# This module contains reusable methods for creating httpc requests to the cloudos_manager.
#
require Logger

defmodule CloudOS.ManagerAPI.Resource do
	alias CloudOS.ManagerAPI
	alias CloudOS.ManagerAPI.Response

  @moduledoc """
  This module contains reusable methods for creating httpc requests to the cloudos_manager.
  """

  @doc """
  Method to execute a GET httpc request

  ## Option Values

  The `api` option defines the ManagerAPI pid

  The `path` option represents the relative url path

  The `headers` option represents a KeyWord list of headers

  The `options` option represents a KeyWord list of HTTP options

  ## Return values

  CloudOS.ManagerAPI.Response
  """ 
  @spec get(pid, String.t(), List, List) :: term
  def get(api, path, headers, options) do
    url = get_url(api, path)
    Logger.debug "[CloudOS.ManagerAPI] GET #{url}"

    execute_request(:get, {'#{url}', merge_headers(headers)}, merge_options(options))
      |> Response.from_httpc_response
  end

  @doc """
  Method to execute a POST httpc request

  ## Option Values

  The `api` option defines the ManagerAPI pid

  The `path` option represents the relative url path

  The `object` option represents the payload of the post request

  The `headers` option represents a KeyWord list of headers

  The `options` option represents a KeyWord list of HTTP options

  ## Return values

  CloudOS.ManagerAPI.Response
  """ 
  @spec post(pid, String.t(), term, List, List) :: term
  def post(api, path, object, headers, options) do
    url = get_url(api, path)
    Logger.debug "[CloudOS.ManagerAPI] POST #{url}"
    execute_request(:post, {'#{url}', merge_headers(headers), 'application/json', '#{JSON.encode!(object)}'}, merge_options(options))
      |> Response.from_httpc_response
  end

  @doc """
  Method to execute a PUT httpc request

  ## Option Values

  The `api` option defines the ManagerAPI pid

  The `path` option represents the relative url path

  The `object` option represents the payload of the post request

  The `headers` option represents a KeyWord list of headers

  The `options` option represents a KeyWord list of HTTP options

  ## Return values

  CloudOS.ManagerAPI.Response
  """ 
  @spec put(pid, String.t(), term, List, List) :: term
  def put(api, path, object, headers, options) do
    url = get_url(api, path)
    Logger.debug "[CloudOS.ManagerAPI] PUT #{url}"
    execute_request(:put, {'#{url}', merge_headers(headers), 'application/json', '#{JSON.encode!(object)}'}, merge_options(options))
      |> Response.from_httpc_response
  end

  @doc """
  Method to execute a POST httpc request

  ## Option Values

  The `api` option defines the ManagerAPI pid

  The `path` option represents the relative url path

  The `headers` option represents a KeyWord list of headers

  The `options` option represents a KeyWord list of HTTP options

  ## Return values

  CloudOS.ManagerAPI.Response
  """ 
  @spec delete(pid, String.t(), List, List) :: term
  def delete(api, path, headers, options) do
    url = get_url(api, path)
    Logger.debug "[CloudOS.ManagerAPI] DELETE #{url}"
    execute_request(:delete, {'#{url}', merge_headers(headers)}, merge_options(options))
      |> Response.from_httpc_response
  end

  # @doc """
  # Method to generate an absolute url from a relative

  # ## Option Values

  # The `api` option defines the ManagerAPI pid

  # The `path` option represents the relative url path

  # ## Return values

  # Absolute URL
  # """ 
  @spec get_url(pid, String.t()) :: String.t()
  defp get_url(api, path) do
  	opts = ManagerAPI.get_options(api)
    path = Regex.replace(~r/^\//, path, "") # strip leading slash, if present
    opts[:manager_url] <> "/" <> path
  end

  @doc """
  Method to generate an relative path, including query params

  ## Option Values

  The `default_path` option represents the relative url

  The `query_params` option represents map of query param names to values

  ## Return values

  Absolute URL
  """ 
  @spec get_path(pid, Map) :: String.t()
  def get_path(default_path, query_params) do
    case build_query_string_from_params(query_params) do
      "" ->
        default_path
      querystring ->
        default_path <> querystring
    end
  end

  @doc """
  Method to generate a query param string

  ## Option Values

  The `query_params` option represents map of query param names to values

  ## Return values

  Query string
  """ 
  @spec build_query_string_from_params(Map) :: String.t()
  def build_query_string_from_params(query_params) do
    Enum.reduce(
      Map.keys(query_params),
      "",
      fn(key, acc) ->
        if String.length(acc) == 0 do
          acc = "?"
        else
          acc = acc <> "&"
        end
        acc <> "#{key}=#{query_params[key]}"
      end
    )
  end

  @doc false
  # Method to merge custom HTTP options
  #
  ## Options
  #
  # The `options` option represents the list of HTTP options
  #
  ## Return Value
  #
  # List
  #
  @spec merge_options(List) :: List
  defp merge_options(options) do
    options ++ []
  end

  @doc false
  # Method to load the default headers
  #
  ## Options
  #
  ## Return Value
  #
  # List
  #
  @spec default_headers() :: List
  defp default_headers do
    token = CloudosAuth.Client.get_token(Application.get_env(:cloudos_manager_api, :oauth_login_url),
                                 Application.get_env(:cloudos_manager_api, :oauth_client_id),
                                 Application.get_env(:cloudos_manager_api, :oauth_client_secret))
    [{'Accept', 'application/json'}, {'Content-Type', 'application/json'},
     {'User-Agent','cloudos-manager-api'}, {'Authorization', 'Bearer access_token=#{token}'}]
  end

  @doc false
  # Method to merge custom headers
  #
  ## Options
  #
  # The `headers` option represents the list of headers
  #
  ## Return Value
  #
  # List
  #
  @spec merge_headers(List) :: List
  defp merge_headers(headers) do
    if headers != nil && length(headers) > 0 do
      default_headers_map = Enum.reduce default_headers, %{}, fn (header, default_headers_map) ->
        Map.put(default_headers_map, '#{elem(header, 0)}', '#{elem(header, 1)}')
      end

      new_headers_map = Enum.reduce headers, default_headers_map, fn(header, new_headers_map) ->
        Map.put(new_headers_map, '#{elem(header, 0)}', '#{elem(header, 1)}')
      end

      Map.to_list(new_headers_map)
    else
      default_headers
    end
  end

  @doc false
  # Method to execute an httpc request
  #
  ## Options
  #
  # The `method` option represents an atom of the HTTP options
  #
  # The `request` option represents the httpc request
  #
  # The `http_options` option represents the HTTP options
  #
  ## Return Value
  #
  # httpc response tuple
  #
  @spec execute_request(term, term, List) :: term
  defp execute_request(method, request, http_options) do
    httpc_options = []
    :httpc.request(method, request, http_options, httpc_options)
  end  
end