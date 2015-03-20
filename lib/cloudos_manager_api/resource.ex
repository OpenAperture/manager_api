require Logger

defmodule CloudOS.ManagerAPI.Resource do
	alias CloudOS.ManagerAPI
	alias CloudOS.ManagerAPI.Response

  @moduledoc """
  This module is used to issue HTTP requests.
  """

  def get(api, path, headers, options) do
    url = get_url(api, path)
    Logger.debug "[CloudOS.ManagerAPI] GET #{url}"

    execute_request(:get, {'#{url}', merge_headers(headers)}, merge_options(options))
      |> Response.from_httpc_response
  end

  def post(api,path, object, headers, options) do
    url = get_url(api, path)
    Logger.debug "[CloudOS.ManagerAPI] POST #{url}"
    execute_request(:post, {'#{url}', merge_headers(headers), 'application/json', '#{JSON.encode!(object)}'}, merge_options(options))
      |> Response.from_httpc_response
  end

  def put(api, path, object, headers, options) do
    url = get_url(api, path)
    Logger.debug "[CloudOS.ManagerAPI] PUT #{url}"
    execute_request(:put, {'#{url}', merge_headers(headers), 'application/json', '#{JSON.encode!(object)}'}, merge_options(options))
      |> Response.from_httpc_response
  end

  def delete(api, path, headers, options) do
    url = get_url(api, path)
    Logger.debug "[CloudOS.ManagerAPI] DELETE #{url}"
    execute_request(:delete, {'#{url}', merge_headers(headers)}, merge_options(options))
      |> Response.from_httpc_response
  end

  defp get_url(api, path) do
  	opts = ManagerAPI.get_options(api)
    path = Regex.replace(~r/^\//, path, "") # strip leading slash, if present
    opts[:url] <> "/" <> path
  end

  def get_path(default_path, queryparams) do
    case build_query_string_from_params(queryparams) do
      "" ->
        default_path
      querystring ->
        default_path <> querystring
    end
  end

  @doc """
  Build a query string from a map of parmeters
  """
  def build_query_string_from_params(queryparams) do
    Enum.reduce(
      Map.keys(queryparams),
      "",
      fn(key, acc) ->
        if String.length(acc) == 0 do
          acc = "?"
        else
          acc = acc <> "&"
        end
        acc <> "#{key}=#{queryparams[key]}"
      end
    )
  end

  defp merge_options(options) do
    options ++ []
  end

  defp default_headers do
    [{'Accept', 'application/json'}, {'Content-Type', 'application/json'}, {'User-Agent','cloudos-manager-api'}]
  end

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

  defp execute_request(method, request, http_options) do
    #http://www.erlang.org/doc/man/httpc.html#request-4
    httpc_options = []
    :httpc.request(method, request, http_options, httpc_options)
  end  
end