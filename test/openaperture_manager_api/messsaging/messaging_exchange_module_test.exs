defmodule OpenAperture.ManagerApi.MessagingExchangeModuleTest do
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
    use_cassette "list_modules", custom: true do
      response = OpenAperture.ManagerApi.MessagingExchangeModule.list(1)
      assert response != nil
      assert response.success? == true
      assert response.status == 200

      exchanges = response.body
      assert exchanges != nil
      assert length(exchanges) == 2
      is_successful = Enum.reduce exchanges, true, fn (exchange, is_successful) ->
        if is_successful do
          cond do
            exchange["id"] == "1" && exchange["hostname"] == "123abc" -> true
            exchange["id"] == "2" && exchange["hostname"] == "2345" -> true
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
    use_cassette "list_modules", custom: true do
      response = OpenAperture.ManagerApi.MessagingExchangeModule.list(context[:api], 1)
      assert response != nil
      assert response.success? == true
      assert response.status == 200

      exchanges = response.body
      assert exchanges != nil
      assert length(exchanges) == 2
      is_successful = Enum.reduce exchanges, true, fn (exchange, is_successful) ->
        if is_successful do
          cond do
            exchange["id"] == "1" && exchange["hostname"] == "123abc" -> true
            exchange["id"] == "2" && exchange["hostname"] == "2345" -> true
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
    use_cassette "list_modules_failure", custom: true do
      response = OpenAperture.ManagerApi.MessagingExchangeModule.list(context[:api], 1)
      assert response != nil
      assert response.success? == false
      assert response.status == 401
    end
  end

  # =============================
  # list! tests

  test "list! - success", context do
    use_cassette "list_modules", custom: true do
      exchanges = OpenAperture.ManagerApi.MessagingExchangeModule.list!(context[:api], 1)
      assert exchanges != nil
      assert length(exchanges) == 2
      is_successful = Enum.reduce exchanges, true, fn (exchange, is_successful) ->
        if is_successful do
          cond do
            exchange["id"] == "1" && exchange["hostname"] == "123abc" -> true
            exchange["id"] == "2" && exchange["hostname"] == "2345" -> true
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
    use_cassette "list_modules_failure", custom: true do
      exchanges = OpenAperture.ManagerApi.MessagingExchangeModule.list!(context[:api], 1)
      assert exchanges == nil
    end
  end

  # =============================
  # get_module tests

  test "supervised get_module - success" do
    use_cassette "get_module", custom: true do
      response = OpenAperture.ManagerApi.MessagingExchangeModule.get_module(1, "123abc")
      assert response != nil
      assert response.success? == true
      assert response.status == 200

      exchange = response.body
      assert exchange != nil
      assert exchange["id"] == "1" 
      assert exchange["hostname"] == "123abc"
    end
  end

  test "get_module - success", context do
    use_cassette "get_module", custom: true do
      response = OpenAperture.ManagerApi.MessagingExchangeModule.get_module(context[:api], 1, "123abc")
      assert response != nil
      assert response.success? == true
      assert response.status == 200

      exchange = response.body
      assert exchange != nil
      assert exchange["id"] == "1"
      assert exchange["hostname"] == "123abc"
    end
  end

  test "get_module - failure", context do
    use_cassette "get_module_failure", custom: true do
      response = OpenAperture.ManagerApi.MessagingExchangeModule.get_module(context[:api], 1, "123abc")
      assert response != nil
      assert response.success? == false
      assert response.status == 401
    end
  end

  # =============================
  # get_module! tests

  test "get_module! - success", context do
    use_cassette "get_module", custom: true do
      exchange = OpenAperture.ManagerApi.MessagingExchangeModule.get_module!(context[:api], 1, "123abc")
      assert exchange != nil
      assert exchange["id"] == "1" 
      assert exchange["hostname"] == "123abc"
    end
  end

  test "get_module! - failure", context do
    use_cassette "get_module_failure", custom: true do
      exchange = OpenAperture.ManagerApi.MessagingExchangeModule.get_module!(context[:api], 1, "123abc")
      assert exchange == nil
    end
  end

  # =============================
  # create_module tests

  test "supervised create_module - success" do
    use_cassette "create_module", custom: true do
      response = OpenAperture.ManagerApi.MessagingExchangeModule.create_module(1, %{hostname: "123abc"})
      assert response != nil
      assert response.success? == true
      assert response.status == 201
      assert Response.extract_identifier_from_location_header(response) == "123abc"
    end
  end

  test "create_module - success", context do
    use_cassette "create_module", custom: true do
      response = OpenAperture.ManagerApi.MessagingExchangeModule.create_module(context[:api], 1, %{hostname: "123abc"})
      assert response != nil
      assert response.success? == true
      assert response.status == 201
      assert Response.extract_identifier_from_location_header(response) == "123abc"
    end
  end

  test "create_module - failure", context do
    use_cassette "create_module_failure", custom: true do
      response = OpenAperture.ManagerApi.MessagingExchangeModule.create_module(context[:api], 1, %{hostname: "123abc"})
      assert response != nil
      assert response.success? == false
      assert response.status == 400
    end
  end

  # =============================
  # create_module! tests

  test "create_module! - success", context do
    use_cassette "create_module", custom: true do
      exchange_id = OpenAperture.ManagerApi.MessagingExchangeModule.create_module!(context[:api], 1, %{hostname: "123abc"})
      assert exchange_id != nil
      assert exchange_id == "123abc"
    end
  end

  test "create_module! - failure", context do
    use_cassette "create_module_failure", custom: true do
      exchange_id = OpenAperture.ManagerApi.MessagingExchangeModule.create_module!(context[:api], 1, %{hostname: "123abc"})
      assert exchange_id == nil
    end
  end

  # =============================
  # delete_module tests

  test "supervised delete_module - success" do
    use_cassette "delete_module", custom: true do
      response = OpenAperture.ManagerApi.MessagingExchangeModule.delete_module(1, "123abc")
      assert response != nil
      assert response.success? == true
      assert response.status == 204
    end
  end

  test "delete_module - success", context do
    use_cassette "delete_module", custom: true do
      response = OpenAperture.ManagerApi.MessagingExchangeModule.delete_module(context[:api], 1, "123abc")
      assert response != nil
      assert response.success? == true
      assert response.status == 204
    end
  end

  test "delete_module - failure", context do
    use_cassette "delete_module_failure", custom: true do
      response = OpenAperture.ManagerApi.MessagingExchangeModule.delete_module(context[:api], 1, "123abc")
      assert response != nil
      assert response.success? == false
      assert response.status == 401
    end
  end

  # =============================
  # delete_module! tests

  test "delete_module! - success", context do
    use_cassette "delete_module", custom: true do
      exchange_id = OpenAperture.ManagerApi.MessagingExchangeModule.delete_module!(context[:api], 1, "123abc")
      assert exchange_id != nil
      assert exchange_id == true
    end
  end

  test "delete_module! - failure", context do
    use_cassette "delete_module_failure", custom: true do
      exchange_id = OpenAperture.ManagerApi.MessagingExchangeModule.delete_module!(context[:api], 1, "123abc")
      assert exchange_id == false
    end
  end  
end