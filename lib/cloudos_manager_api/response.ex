#
# == response.ex
#
# This module contains the ManagerAPI response struct and reusable methods for processing responses from the cloudos_manager.
#
defmodule CloudOS.ManagerAPI.Response do
  defstruct body: nil, success?: nil, raw_body: nil, status: nil, headers: nil

  @moduledoc """
  This module contains the ManagerAPI response struct and reusable methods for processing responses from the cloudos_manager.
  """ 

  @doc """
  Method to process an incoming http response into a CloudOS.ManagerAPI.Response

  ## Option Values

  The `request` option defines the http request to be processed

  ## Return values

  CloudOS.ManagerAPI.Response
  """ 
  @spec process(term) :: term
  def process(request) do
    try do
      process_response request.()
    catch
      kind, error -> CloudOS.ManagerAPI.Error.process(kind, error)
    end
  end

  @doc """
  Method to process an incoming httpc response into a CloudOS.ManagerAPI.Response

  ## Option Values

  The `response` option defines the httpc response to be processed

  ## Return values

  CloudOS.ManagerAPI.Response
  """ 
  @spec from_httpc_response(term) :: term
  def from_httpc_response(response) do
    case response do
      {:ok, {{_http_ver,return_code, _return_code_desc}, headers, body}} -> 
        process_response({:ok, %{status_code: return_code, headers: headers, body: "#{body}"}})
      {:error, {failure_reason, _}} -> 
        process_response({:error, %{reason: "#{inspect failure_reason}"}})
    end
  end

  @doc """
  Method to extract an identifier from the Location header of a response

  ## Option Values

  The `response` option defines the CloudOS.ManagerAPI.Response

  ## Return values

  String identifier
  """ 
  @spec extract_identifier_from_location_header(term) :: String.t()
  def extract_identifier_from_location_header(response) do
    if response.headers == nil || length(response.headers) == 0 do
      ""
    else
      location_header = Enum.reduce response.headers, nil, fn({header, value}, location_header) ->
        if header != nil && String.downcase(header) == "location" do
          value
        else
          location_header
        end
      end

      case location_header do
        nil -> ""
        "" -> ""
        location_header ->
          url = Regex.replace(~r/\/$/, location_header, "")
          uri = URI.parse(url)
          uri_path = String.split(uri.path, "/")
          List.last(uri_path)
      end
    end
  end

  @doc false
  # Method to process an incoming httpc :ok response into a CloudOS.ManagerAPI.Response
  #
  ## Options
  #
  # The `response` option represents the httpc response
  #
  ## Return Value
  #
  # CloudOS.ManagerAPI.Response
  #
  @spec process_response({:ok, term}) :: term
  defp process_response({:ok, response}) do
    body = response[:body]
      |> String.strip
      |> process_body

    %__MODULE__{
      body: body,
      success?: response[:status_code] in 200..299,
      status: response[:status_code],
      headers: process_headers(response[:headers]),
      raw_body: response[:body]
    }
  end

  @doc false
  # Method to process an incoming httpc :error response into a CloudOS.ManagerAPI.Response
  #
  ## Options
  #
  # The `response` option represents the httpc response
  #
  ## Return Value
  #
  # CloudOS.ManagerAPI.Response
  #
  @spec process_response({:error, term}) :: term
  defp process_response({:error, response}) do
    %__MODULE__{
      body: response[:reason],
      success?: false,
      status: 0,
      headers: process_headers(response[:headers]),
      raw_body: nil
    }    
  end

  @doc false
  # Method to process the body from an incoming httpc response into JSON
  #
  ## Options
  #
  # The `body` option represents the httpc response
  #
  ## Return Value
  #
  # Object
  #
  @spec process_body(term) :: term
  defp process_body(body) when byte_size(body) == 0, do: %{}
  defp process_body(body), do: JSON.decode!(body)

  @doc false
  # Method to process the headers from an incoming httpc response into JSON
  #
  ## Options
  #
  # The `headers` option represents the httpc headers
  #
  ## Return Value
  #
  # List
  #
  @spec process_headers(term) :: List
  defp process_headers(headers) do
    if headers == nil || length(headers) == 0 do
      []
    else
      Enum.reduce headers, [], fn(header, new_headers) ->
        new_headers ++ [{"#{elem(header, 0)}", "#{elem(header, 1)}"}]
      end  
    end
  end
end
