defmodule OpenAperture.ManagerApi.MessagingRpcRequestTest do
  use ExUnit.Case
  use ExVCR.Mock, adapter: ExVCR.Adapter.Httpc, options: [clear_mock: true]

  alias OpenAperture.ManagerApi.Response

  setup_all _context do
    :meck.new(OpenAperture.Auth.Client, [:passthrough])
    :meck.expect(OpenAperture.Auth.Client, :get_token, fn _, _, _ -> "abc" end)

    on_exit _context, fn ->
      try do
        :meck.unload OpenAperture.Auth.Client
      rescue _ -> IO.puts "" end
    end    
    :ok
  end

  setup do
    api = OpenAperture.ManagerApi.create!(%{manager_url: "https://openaperture-mgr.host.co", oauth_login_url: "https://auth.host.co", oauth_client_id: "id", oauth_client_secret: "secret"})

    {:ok, [
      api: api
    ]}
  end    

  # =============================
  # list tests

  test "supervised list - success" do
    use_cassette "list_requests", custom: true do
      response = OpenAperture.ManagerApi.MessagingRpcRequest.list
      assert response != nil
      assert response.success? == true
      assert response.status == 200

      requests = response.body
      assert requests != nil
      assert length(requests) == 2
      is_successful = Enum.reduce requests, true, fn (request, is_successful) ->
        if is_successful do
          cond do
            request["id"] == 1 -> true
            request["id"] == 2 -> true
            true -> false
          end
        else
          is_successful
        end
      end
      assert is_successful == true
    end
  end

  test "list - success", context do
    use_cassette "list_requests", custom: true do
      response = OpenAperture.ManagerApi.MessagingRpcRequest.list(context[:api])
      assert response != nil
      assert response.success? == true
      assert response.status == 200

      requests = response.body
      assert requests != nil
      assert length(requests) == 2
      is_successful = Enum.reduce requests, true, fn (request, is_successful) ->
        if is_successful do
          cond do
            request["id"] == 1 -> true
            request["id"] == 2 -> true
            true -> false
          end
        else
          is_successful
        end
      end
      assert is_successful == true
    end
  end

  test "list - failure", context do
    use_cassette "list_requests_failure", custom: true do
      response = OpenAperture.ManagerApi.MessagingRpcRequest.list(context[:api])
      assert response != nil
      assert response.success? == false
      assert response.status == 401
    end
  end

  # =============================
  # list! tests

  test "list! - success", context do
    use_cassette "list_requests", custom: true do
      requests = OpenAperture.ManagerApi.MessagingRpcRequest.list!(context[:api])
      assert requests != nil
      assert length(requests) == 2
      is_successful = Enum.reduce requests, true, fn (request, is_successful) ->
        if is_successful do
          cond do
            request["id"] == 1 -> true
            request["id"] == 2 -> true
            true -> false
          end
        else
          is_successful
        end
      end
      assert is_successful == true
    end
  end

  test "list! - failure", context do
    use_cassette "list_requests_failure", custom: true do
      requests = OpenAperture.ManagerApi.MessagingRpcRequest.list!(context[:api])
      assert requests == nil
    end
  end

  # =============================
  # get_request tests

  test "supervised get_request - success" do
    use_cassette "get_request", custom: true do
      response = OpenAperture.ManagerApi.MessagingRpcRequest.get_request(1)
      assert response != nil
      assert response.success? == true
      assert response.status == 200

      request = response.body
      assert request != nil
      assert request["id"] == 1
    end
  end

  test "get_request - success", context do
    use_cassette "get_request", custom: true do
      response = OpenAperture.ManagerApi.MessagingRpcRequest.get_request(context[:api], 1)
      assert response != nil
      assert response.success? == true
      assert response.status == 200

      request = response.body
      assert request != nil
      assert request["id"] == 1
    end
  end

  test "get_request - failure", context do
    use_cassette "get_request_failure", custom: true do
      response = OpenAperture.ManagerApi.MessagingRpcRequest.get_request(context[:api], 1)
      assert response != nil
      assert response.success? == false
      assert response.status == 401
    end
  end

  # =============================
  # get_request! tests

  test "get_request! - success", context do
    use_cassette "get_request", custom: true do
      request = OpenAperture.ManagerApi.MessagingRpcRequest.get_request!(context[:api], 1)
      assert request != nil
      assert request["id"] == 1
    end
  end

  test "get_request! - failure", context do
    use_cassette "get_request_failure", custom: true do
      request = OpenAperture.ManagerApi.MessagingRpcRequest.get_request!(context[:api], 1)
      assert request == nil
    end
  end

  # =============================
  # create_request tests

  test "supervised create_request - success" do
    use_cassette "create_request", custom: true do
      response = OpenAperture.ManagerApi.MessagingRpcRequest.create_request(%{status: "not_started"})
      assert response != nil
      assert response.success? == true
      assert response.status == 201
      assert Response.extract_identifier_from_location_header(response) == "1"
    end
  end

  test "create_request - success", context do
    use_cassette "create_request", custom: true do
      response = OpenAperture.ManagerApi.MessagingRpcRequest.create_request(context[:api], %{status: "not_started"})
      assert response != nil
      assert response.success? == true
      assert response.status == 201
      assert Response.extract_identifier_from_location_header(response) == "1"
    end
  end

  test "create_request - failure", context do
    use_cassette "create_request_failure", custom: true do
      response = OpenAperture.ManagerApi.MessagingRpcRequest.create_request(context[:api], %{status: "not_started"})
      assert response != nil
      assert response.success? == false
      assert response.status == 400
    end
  end

  # =============================
  # create_request! tests

  test "create_request! - success", context do
    use_cassette "create_request", custom: true do
      request_id = OpenAperture.ManagerApi.MessagingRpcRequest.create_request!(context[:api], %{status: "not_started"})
      assert request_id != nil
      assert request_id == "1"
    end
  end

  test "create_request! - failure", context do
    use_cassette "create_request_failure", custom: true do
      request_id = OpenAperture.ManagerApi.MessagingRpcRequest.create_request!(context[:api], %{status: "not_started"})
      assert request_id == nil
    end
  end

  # =============================
  # update_request tests

  test "supervised update_request - success" do
    use_cassette "update_request", custom: true do
      response = OpenAperture.ManagerApi.MessagingRpcRequest.update_request(1, %{status: "not_started"})
      assert response != nil
      assert response.success? == true
      assert response.status == 204
      assert Response.extract_identifier_from_location_header(response) == "1"
    end
  end

  test "update_request - success", context do
    use_cassette "update_request", custom: true do
      response = OpenAperture.ManagerApi.MessagingRpcRequest.update_request(context[:api], 1, %{status: "not_started"})
      assert response != nil
      assert response.success? == true
      assert response.status == 204
      assert Response.extract_identifier_from_location_header(response) == "1"
    end
  end

  test "update_request - failure", context do
    use_cassette "update_request_failure", custom: true do
      response = OpenAperture.ManagerApi.MessagingRpcRequest.update_request(context[:api], 1, %{status: "not_started"})
      assert response != nil
      assert response.success? == false
      assert response.status == 401
    end
  end

  # =============================
  # update_request! tests

  test "update_request! - success", context do
    use_cassette "update_request", custom: true do
      request_id = OpenAperture.ManagerApi.MessagingRpcRequest.update_request!(context[:api], 1, %{status: "not_started"})
      assert request_id != nil
      assert request_id == "1"
    end
  end

  test "update_request! - failure", context do
    use_cassette "update_request_failure", custom: true do
      request_id = OpenAperture.ManagerApi.MessagingRpcRequest.update_request!(context[:api], 1, %{status: "not_started"})
      assert request_id == nil
    end
  end  

  # =============================
  # delete_request tests

  test "supervised delete_request - success" do
    use_cassette "delete_request", custom: true do
      response = OpenAperture.ManagerApi.MessagingRpcRequest.delete_request(1)
      assert response != nil
      assert response.success? == true
      assert response.status == 204
    end
  end

  test "delete_request - success", context do
    use_cassette "delete_request", custom: true do
      response = OpenAperture.ManagerApi.MessagingRpcRequest.delete_request(context[:api], 1)
      assert response != nil
      assert response.success? == true
      assert response.status == 204
    end
  end

  test "delete_request - failure", context do
    use_cassette "delete_request_failure", custom: true do
      response = OpenAperture.ManagerApi.MessagingRpcRequest.delete_request(context[:api], 1)
      assert response != nil
      assert response.success? == false
      assert response.status == 401
    end
  end

  # =============================
  # delete_request! tests

  test "delete_request! - success", context do
    use_cassette "delete_request", custom: true do
      request_id = OpenAperture.ManagerApi.MessagingRpcRequest.delete_request!(context[:api], 1)
      assert request_id != nil
      assert request_id == true
    end
  end

  test "delete_request! - failure", context do
    use_cassette "delete_request_failure", custom: true do
      request_id = OpenAperture.ManagerApi.MessagingRpcRequest.delete_request!(context[:api], 1)
      assert request_id == false
    end
  end
end