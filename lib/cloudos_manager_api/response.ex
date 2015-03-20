defmodule CloudOS.ManagerAPI.Response do
  defstruct body: nil, success?: nil, raw_body: nil, status: nil, headers: nil

  def process(request) do
    try do
      process_response request.()
    catch
      kind, error -> CloudOS.ManagerAPI.Error.process(kind, error)
    end
  end

  def from_httpc_response(response) do
    case response do
      {:ok, {{_http_ver,return_code, _return_code_desc}, headers, body}} -> 
        process_response({:ok, %{status_code: return_code, headers: headers, body: "#{body}"}})
      {:error, {failure_reason, _}} -> 
        process_response({:error, %{reason: "#{inspect failure_reason}"}})
    end
  end

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

  defp process_response({:error, response}) do
    %__MODULE__{
      body: response[:reason],
      success?: false,
      status: 0,
      headers: process_headers(response[:headers]),
      raw_body: nil
    }    
  end

  defp process_body(body) when byte_size(body) == 0, do: %{}
  defp process_body(body), do: JSON.decode!(body)

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
