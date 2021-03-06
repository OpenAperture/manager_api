#
# == resource.ex
#
# This module contains reusable methods for creating httpc requests to the openaperture_manager.
#
require Logger

defmodule OpenAperture.ManagerApi.Resource do
	alias OpenAperture.ManagerApi
	alias OpenAperture.ManagerApi.Response

  @moduledoc """
  This module contains reusable methods for creating httpc requests to the openaperture_manager.
  """

  @doc """
  Method to execute a GET httpc request

  ## Option Values

  The `api` option defines the ManagerApi pid

  The `path` option represents the relative url path

  The `headers` option represents a KeyWord list of headers

  The `options` option represents a KeyWord list of HTTP options

  ## Return values

  OpenAperture.ManagerApi.Response
  """
  @spec get(pid, String.t, list, list) :: Response.t
  def get(api, path, headers, options) do
    url = get_url(api, path)
    Logger.debug "[OpenAperture.ManagerApi] GET #{url}"

    execute_request(:get, {'#{url}', merge_headers(api, headers)}, merge_options(options))
      |> Response.from_httpc_response
  end

  @spec get(pid, String.t) :: Response.t
  def get(api, path) do
    get(api, path, [], [])
  end

  @doc """
  Method to execute a POST httpc request

  ## Option Values

  The `api` option defines the ManagerApi pid

  The `path` option represents the relative url path

  The `object` option represents the payload of the post request

  The `headers` option represents a KeyWord list of headers

  The `options` option represents a KeyWord list of HTTP options

  ## Return values

  OpenAperture.ManagerApi.Response
  """
  @spec post(pid, String.t, term, list, list) :: Response.t
  def post(api, path, object, headers, options) do
    url = get_url(api, path)
    Logger.debug "[OpenAperture.ManagerApi] Encoding POST body..."
    encoded_object = '#{Poison.encode!(object)}'
    Logger.debug "[OpenAperture.ManagerApi] Executing POST #{url}"
    execute_request(:post, {'#{url}', merge_headers(api, headers), 'application/json', encoded_object}, merge_options(options))
      |> Response.from_httpc_response
  end

  @spec post(pid, String.t, any) :: Response.t
  def post(api, path, body) do
    post(api, path, body, [], [])
  end

  @doc """
  Method to execute a PUT httpc request

  ## Option Values

  The `api` option defines the ManagerApi pid

  The `path` option represents the relative url path

  The `object` option represents the payload of the post request

  The `headers` option represents a KeyWord list of headers

  The `options` option represents a KeyWord list of HTTP options

  ## Return values

  OpenAperture.ManagerApi.Response
  """
  @spec put(pid, String.t, term, list, list) :: Response.t
  def put(api, path, object, headers, options) do
    url = get_url(api, path)
    Logger.debug "[OpenAperture.ManagerApi] Encoding PUT body..."
    encoded_object = '#{Poison.encode!(object)}'
    Logger.debug "[OpenAperture.ManagerApi] Executing PUT #{url}"

    execute_request(:put, {'#{url}', merge_headers(api, headers), 'application/json', encoded_object}, merge_options(options))
      |> Response.from_httpc_response
  end

  @spec put(pid, String.t, any) :: Response.t
  def put(api, path, body) do
    put(api, path, body, [], [])
  end

  @doc """
  Method to execute a POST httpc request

  ## Option Values

  The `api` option defines the ManagerApi pid

  The `path` option represents the relative url path

  The `headers` option represents a KeyWord list of headers

  The `options` option represents a KeyWord list of HTTP options

  ## Return values

  OpenAperture.ManagerApi.Response
  """
  @spec delete(pid, String.t, list, list) :: Response.t
  def delete(api, path, headers, options) do
    url = get_url(api, path)
    Logger.debug "[OpenAperture.ManagerApi] DELETE #{url}"
    execute_request(:delete, {'#{url}', merge_headers(api, headers)}, merge_options(options))
      |> Response.from_httpc_response
  end

  @spec delete(pid, String.t) :: Response.t
  def delete(api, path) do
    delete(api, path, [], [])
  end

  # @doc """
  # Method to generate an absolute url from a relative

  # ## Option Values

  # The `api` option defines the ManagerApi pid

  # The `path` option represents the relative url path

  # ## Return values

  # Absolute URL
  # """
  @spec get_url(pid, String.t) :: String.t
  defp get_url(api, path) do
  	opts = ManagerApi.get_options(api)
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
  @spec get_path(pid, map) :: String.t
  def get_path(default_path, query_params) do
    case build_query_string_from_params(query_params) do
      "" ->
        default_path
      querystring ->
        default_path <> querystring
    end
  end

  @spec get_path(String.t) :: String.t
  def get_path(default_path) do
    get_path(default_path, %{})
  end

  @doc """
  Method to generate a query param string

  ## Option Values

  The `query_params` option represents map of query param names to values

  ## Return values

  Query string
  """
  @spec build_query_string_from_params(map) :: String.t
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
  @spec merge_options(list) :: list
  defp merge_options(options) do
    options ++ []
  end

  # Method to load the default headers
  @spec default_headers(pid) :: list
  defp default_headers(api) do
    opts = ManagerApi.get_options(api)

    token = cond do
      opts[:oauth_login_url] == nil ->
        Logger.error("[OpenAperture.ManagerApi] Unable to authenticate request - define :oauth_login_url in your options!")
        ""
      opts[:oauth_client_id] == nil ->
        Logger.error("[OpenAperture.ManagerApi] Unable to authenticate request - define :oauth_client_id in your options!")
        ""
      opts[:oauth_client_secret] == nil ->
        Logger.error("[OpenAperture.ManagerApi] Unable to authenticate request - define :oauth_client_secret in your options!")
        ""
      true -> OpenAperture.Auth.Client.get_token(opts[:oauth_login_url], opts[:oauth_client_id], opts[:oauth_client_secret])
    end

    [{'Accept', 'application/json'}, {'Content-Type', 'application/json'},
     {'User-Agent','openaperture-manager-api'}, {'Authorization', 'Bearer access_token=#{token}'}]
  end

  # Method to merge custom headers
  @spec merge_headers(pid, list) :: list
  defp merge_headers(api, headers) do
    if headers != nil && length(headers) > 0 do
      default_headers_map = Enum.reduce default_headers(api), %{}, fn (header, default_headers_map) ->
        Map.put(default_headers_map, '#{elem(header, 0)}', '#{elem(header, 1)}')
      end

      new_headers_map = Enum.reduce headers, default_headers_map, fn(header, new_headers_map) ->
        Map.put(new_headers_map, '#{elem(header, 0)}', '#{elem(header, 1)}')
      end

      Map.to_list(new_headers_map)
    else
      default_headers(api)
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
  @spec execute_request(term, term, term) :: term
  defp execute_request(method, request, http_options) do
    httpc_options = []
    :httpc.request(method, request, http_options, httpc_options)
  end
end
