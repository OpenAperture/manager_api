defmodule OpenAperture.ManagerApi.MessagingExchangeTest do
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
    use_cassette "list_exchanges", custom: true do
      response = OpenAperture.ManagerApi.MessagingExchange.list
      assert response != nil
      assert response.success? == true
      assert response.status == 200

      exchanges = response.body
      assert exchanges != nil
      assert length(exchanges) == 2
      is_successful = Enum.reduce exchanges, true, fn (exchange, is_successful) ->
        if is_successful do
          cond do
            exchange["id"] == 1 && exchange["name"] == "test exchange" -> true
            exchange["id"] == 2 && exchange["name"] == "second exchange" -> true
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
    use_cassette "list_exchanges", custom: true do
      response = OpenAperture.ManagerApi.MessagingExchange.list(context[:api])
      assert response != nil
      assert response.success? == true
      assert response.status == 200

      exchanges = response.body
      assert exchanges != nil
      assert length(exchanges) == 2
      is_successful = Enum.reduce exchanges, true, fn (exchange, is_successful) ->
        if is_successful do
          cond do
            exchange["id"] == 1 && exchange["name"] == "test exchange" -> true
            exchange["id"] == 2 && exchange["name"] == "second exchange" -> true
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
    use_cassette "list_exchanges_failure", custom: true do
      response = OpenAperture.ManagerApi.MessagingExchange.list(context[:api])
      assert response != nil
      assert response.success? == false
      assert response.status == 401
    end
  end

  # =============================
  # list! tests

  test "list! - success", context do
    use_cassette "list_exchanges", custom: true do
      exchanges = OpenAperture.ManagerApi.MessagingExchange.list!(context[:api])
      assert exchanges != nil
      assert length(exchanges) == 2
      is_successful = Enum.reduce exchanges, true, fn (exchange, is_successful) ->
        if is_successful do
          cond do
            exchange["id"] == 1 && exchange["name"] == "test exchange" -> true
            exchange["id"] == 2 && exchange["name"] == "second exchange" -> true
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
    use_cassette "list_exchanges_failure", custom: true do
      exchanges = OpenAperture.ManagerApi.MessagingExchange.list!(context[:api])
      assert exchanges == nil
    end
  end

  # =============================
  # get_exchange tests

  test "supervised get_exchange - success" do
    use_cassette "get_exchange", custom: true do
      response = OpenAperture.ManagerApi.MessagingExchange.get_exchange(1)
      assert response != nil
      assert response.success? == true
      assert response.status == 200

      exchange = response.body
      assert exchange != nil
      assert exchange["id"] == 1 
      assert exchange["name"] == "test exchange"
    end
  end

  test "get_exchange - success", context do
    use_cassette "get_exchange", custom: true do
      response = OpenAperture.ManagerApi.MessagingExchange.get_exchange(context[:api], 1)
      assert response != nil
      assert response.success? == true
      assert response.status == 200

      exchange = response.body
      assert exchange != nil
      assert exchange["id"] == 1 
      assert exchange["name"] == "test exchange"
    end
  end

  test "get_exchange - failure", context do
    use_cassette "get_exchange_failure", custom: true do
      response = OpenAperture.ManagerApi.MessagingExchange.get_exchange(context[:api], 1)
      assert response != nil
      assert response.success? == false
      assert response.status == 401
    end
  end

  # =============================
  # get_exchange! tests

  test "get_exchange! - success", context do
    use_cassette "get_exchange", custom: true do
      exchange = OpenAperture.ManagerApi.MessagingExchange.get_exchange!(context[:api], 1)
      assert exchange != nil
      assert exchange["id"] == 1 
      assert exchange["name"] == "test exchange"
    end
  end

  test "get_exchange! - failure", context do
    use_cassette "get_exchange_failure", custom: true do
      exchange = OpenAperture.ManagerApi.MessagingExchange.get_exchange!(context[:api], 1)
      assert exchange == nil
    end
  end

  # =============================
  # create_exchange tests

  test "supervised create_exchange - success" do
    use_cassette "create_exchange", custom: true do
      response = OpenAperture.ManagerApi.MessagingExchange.create_exchange(%{name: "test exchange"})
      assert response != nil
      assert response.success? == true
      assert response.status == 201
      assert Response.extract_identifier_from_location_header(response) == "1"
    end
  end

  test "create_exchange - success", context do
    use_cassette "create_exchange", custom: true do
      response = OpenAperture.ManagerApi.MessagingExchange.create_exchange(context[:api], %{name: "test exchange"})
      assert response != nil
      assert response.success? == true
      assert response.status == 201
      assert Response.extract_identifier_from_location_header(response) == "1"
    end
  end

  test "create_exchange - failure", context do
    use_cassette "create_exchange_failure", custom: true do
      response = OpenAperture.ManagerApi.MessagingExchange.create_exchange(context[:api], %{name: "test exchange"})
      assert response != nil
      assert response.success? == false
      assert response.status == 400
    end
  end

  # =============================
  # create_exchange! tests

  test "create_exchange! - success", context do
    use_cassette "create_exchange", custom: true do
      exchange_id = OpenAperture.ManagerApi.MessagingExchange.create_exchange!(context[:api], %{name: "test exchange"})
      assert exchange_id != nil
      assert exchange_id == "1"
    end
  end

  test "create_exchange! - failure", context do
    use_cassette "create_exchange_failure", custom: true do
      exchange_id = OpenAperture.ManagerApi.MessagingExchange.create_exchange!(context[:api], %{name: "test exchange"})
      assert exchange_id == nil
    end
  end

  # =============================
  # update_exchange tests

  test "supervised update_exchange - success" do
    use_cassette "update_exchange", custom: true do
      response = OpenAperture.ManagerApi.MessagingExchange.update_exchange(1, %{name: "test exchange"})
      assert response != nil
      assert response.success? == true
      assert response.status == 204
      assert Response.extract_identifier_from_location_header(response) == "1"
    end
  end

  test "update_exchange - success", context do
    use_cassette "update_exchange", custom: true do
      response = OpenAperture.ManagerApi.MessagingExchange.update_exchange(context[:api], 1, %{name: "test exchange"})
      assert response != nil
      assert response.success? == true
      assert response.status == 204
      assert Response.extract_identifier_from_location_header(response) == "1"
    end
  end

  test "update_exchange - failure", context do
    use_cassette "update_exchange_failure", custom: true do
      response = OpenAperture.ManagerApi.MessagingExchange.update_exchange(context[:api], 1, %{name: "test exchange"})
      assert response != nil
      assert response.success? == false
      assert response.status == 401
    end
  end

  # =============================
  # update_exchange! tests

  test "update_exchange! - success", context do
    use_cassette "update_exchange", custom: true do
      exchange_id = OpenAperture.ManagerApi.MessagingExchange.update_exchange!(context[:api], 1, %{name: "test exchange"})
      assert exchange_id != nil
      assert exchange_id == "1"
    end
  end

  test "update_exchange! - failure", context do
    use_cassette "update_exchange_failure", custom: true do
      exchange_id = OpenAperture.ManagerApi.MessagingExchange.update_exchange!(context[:api], 1, %{name: "test exchange"})
      assert exchange_id == nil
    end
  end

  # =============================
  # delete_exchange tests

  test "supervised delete_exchange - success" do
    use_cassette "delete_exchange", custom: true do
      response = OpenAperture.ManagerApi.MessagingExchange.delete_exchange(1)
      assert response != nil
      assert response.success? == true
      assert response.status == 204
    end
  end

  test "delete_exchange - success", context do
    use_cassette "delete_exchange", custom: true do
      response = OpenAperture.ManagerApi.MessagingExchange.delete_exchange(context[:api], 1)
      assert response != nil
      assert response.success? == true
      assert response.status == 204
    end
  end

  test "delete_exchange - failure", context do
    use_cassette "delete_exchange_failure", custom: true do
      response = OpenAperture.ManagerApi.MessagingExchange.delete_exchange(context[:api], 1)
      assert response != nil
      assert response.success? == false
      assert response.status == 401
    end
  end

  # =============================
  # delete_exchange! tests

  test "delete_exchange! - success", context do
    use_cassette "delete_exchange", custom: true do
      exchange_id = OpenAperture.ManagerApi.MessagingExchange.delete_exchange!(context[:api], 1)
      assert exchange_id != nil
      assert exchange_id == true
    end
  end

  test "delete_exchange! - failure", context do
    use_cassette "delete_exchange_failure", custom: true do
      exchange_id = OpenAperture.ManagerApi.MessagingExchange.delete_exchange!(context[:api], 1)
      assert exchange_id == false
    end
  end  

 # =============================
  # create_broker_connection tests

  test "supervised create_exchange_brokers - success" do
    use_cassette "create_exchange_brokers", custom: true do
      response = OpenAperture.ManagerApi.MessagingExchange.create_exchange_brokers(1, %{name: "test broker"})
      assert response != nil
      assert response.success? == true
      assert response.status == 201
    end
  end

  test "create_exchange_brokers - success", context do
    use_cassette "create_exchange_brokers", custom: true do
      response = OpenAperture.ManagerApi.MessagingExchange.create_exchange_brokers(context[:api], 1, %{name: "test broker"})
      assert response != nil
      assert response.success? == true
      assert response.status == 201
    end
  end

  test "create_exchange_brokers - failure", context do
    use_cassette "create_exchange_brokers_failure", custom: true do
      response = OpenAperture.ManagerApi.MessagingExchange.create_exchange_brokers(context[:api], 1, %{name: "test broker"})
      assert response != nil
      assert response.success? == false
      assert response.status == 400
    end
  end

  # =============================
  # create_exchange_brokers! tests

  test "create_exchange_brokers! - success", context do
    use_cassette "create_exchange_brokers", custom: true do
      broker_id = OpenAperture.ManagerApi.MessagingExchange.create_exchange_brokers!(context[:api], 1, %{name: "test broker"})
      assert broker_id != nil
      assert broker_id == true
    end
  end

  test "create_exchange_brokers! - failure", context do
    use_cassette "create_exchange_brokers_failure", custom: true do
      broker_id = OpenAperture.ManagerApi.MessagingExchange.create_exchange_brokers!(context[:api], 1, %{name: "test broker"})
      assert broker_id == false
    end
  end

  # =============================
  # exchange_brokers tests

  test "supervised exchange_brokers - success" do
    use_cassette "exchange_brokers", custom: true do
      response = OpenAperture.ManagerApi.MessagingExchange.exchange_brokers(1)
      assert response != nil
      assert response.success? == true
      assert response.status == 200

      brokers = response.body
      assert brokers != nil
      assert length(brokers) == 2
      is_successful = Enum.reduce brokers, true, fn (broker, is_successful) ->
        if is_successful do
          cond do
            broker["id"] == 1 && broker["username"] == "test" -> true
            broker["id"] == 2 && broker["username"] == "test2" -> true
            true -> false
          end
        else
          is_successful
        end
      end
      assert is_successful == true
    end
  end

  test "exchange_brokers - success", context do
    use_cassette "exchange_brokers", custom: true do
      response = OpenAperture.ManagerApi.MessagingExchange.exchange_brokers(context[:api], 1)
      assert response != nil
      assert response.success? == true
      assert response.status == 200

      brokers = response.body
      assert brokers != nil
      assert length(brokers) == 2
      is_successful = Enum.reduce brokers, true, fn (broker, is_successful) ->
        if is_successful do
          cond do
            broker["id"] == 1 && broker["username"] == "test" -> true
            broker["id"] == 2 && broker["username"] == "test2" -> true
            true -> false
          end
        else
          is_successful
        end
      end
      assert is_successful == true
    end
  end

  test "exchange_brokers - failure", context do
    use_cassette "exchange_brokers_failure", custom: true do
      response = OpenAperture.ManagerApi.MessagingExchange.exchange_brokers(context[:api], 1)
      assert response != nil
      assert response.success? == false
      assert response.status == 401
    end
  end

  # =============================
  # exchange_brokers! tests

  test "exchange_brokers! - success", context do
    use_cassette "exchange_brokers", custom: true do
      brokers = OpenAperture.ManagerApi.MessagingExchange.exchange_brokers!(context[:api], 1)
      assert brokers != nil
      assert length(brokers) == 2
      is_successful = Enum.reduce brokers, true, fn (broker, is_successful) ->
        if is_successful do
          cond do
            broker["id"] == 1 && broker["username"] == "test" -> true
            broker["id"] == 2 && broker["username"] == "test2" -> true
            true -> false
          end
        else
          is_successful
        end
      end
      assert is_successful == true
    end
  end

  test "exchange_brokers! - failure", context do
    use_cassette "exchange_brokers_failure", custom: true do
      brokers = OpenAperture.ManagerApi.MessagingExchange.exchange_brokers!(context[:api], 1)
      assert brokers == nil
    end
  end

  # =============================
  # delete_exchange_brokers tests

  test "supervised delete_exchange_brokers - success" do
    use_cassette "delete_exchange_brokers", custom: true do
      response = OpenAperture.ManagerApi.MessagingExchange.delete_exchange_brokers(1)
      assert response != nil
      assert response.success? == true
      assert response.status == 204
    end
  end

  test "delete_exchange_brokers - success", context do
    use_cassette "delete_exchange_brokers", custom: true do
      response = OpenAperture.ManagerApi.MessagingExchange.delete_exchange_brokers(context[:api], 1)
      assert response != nil
      assert response.success? == true
      assert response.status == 204
    end
  end

  test "delete_exchange_brokers - failure", context do
    use_cassette "delete_exchange_brokers_failure", custom: true do
      response = OpenAperture.ManagerApi.MessagingExchange.delete_exchange_brokers(context[:api], 1)
      assert response != nil
      assert response.success? == false
      assert response.status == 401
    end
  end

  # =============================
  # delete_exchange_brokers! tests

  test "delete_exchange_brokers! - success", context do
    use_cassette "delete_exchange_brokers", custom: true do
      broker_id = OpenAperture.ManagerApi.MessagingExchange.delete_exchange_brokers!(context[:api], 1)
      assert broker_id != nil
      assert broker_id == true
    end
  end

  test "delete_exchange_brokers! - failure", context do
    use_cassette "delete_exchange_brokers_failure", custom: true do
      broker_id = OpenAperture.ManagerApi.MessagingExchange.delete_exchange_brokers!(context[:api], 1)
      assert broker_id == false
    end
  end 

  # =============================
  # exchange_clusters tests

  test "supervised exchange_clusters - success" do
    use_cassette "exchange_clusters", custom: true do
      response = OpenAperture.ManagerApi.MessagingExchange.exchange_clusters(1)
      assert response != nil
      assert response.success? == true
      assert response.status == 200

      brokers = response.body
      assert brokers != nil
      assert length(brokers) == 2
      is_successful = Enum.reduce brokers, true, fn (broker, is_successful) ->
        if is_successful do
          cond do
            broker["id"] == 1 && broker["username"] == "test" -> true
            broker["id"] == 2 && broker["username"] == "test2" -> true
            true -> false
          end
        else
          is_successful
        end
      end
      assert is_successful == true
    end
  end

  test "exchange_clusters - success", context do
    use_cassette "exchange_clusters", custom: true do
      response = OpenAperture.ManagerApi.MessagingExchange.exchange_clusters(context[:api], 1)
      assert response != nil
      assert response.success? == true
      assert response.status == 200

      brokers = response.body
      assert brokers != nil
      assert length(brokers) == 2
      is_successful = Enum.reduce brokers, true, fn (broker, is_successful) ->
        if is_successful do
          cond do
            broker["id"] == 1 && broker["username"] == "test" -> true
            broker["id"] == 2 && broker["username"] == "test2" -> true
            true -> false
          end
        else
          is_successful
        end
      end
      assert is_successful == true
    end
  end

  test "exchange_clusters - failure", context do
    use_cassette "exchange_clusters_failure", custom: true do
      response = OpenAperture.ManagerApi.MessagingExchange.exchange_clusters(context[:api], 1)
      assert response != nil
      assert response.success? == false
      assert response.status == 401
    end
  end

  # =============================
  # exchange_clusters! tests

  test "exchange_clusters! - success", context do
    use_cassette "exchange_clusters", custom: true do
      brokers = OpenAperture.ManagerApi.MessagingExchange.exchange_clusters!(context[:api], 1)
      assert brokers != nil
      assert length(brokers) == 2
      is_successful = Enum.reduce brokers, true, fn (broker, is_successful) ->
        if is_successful do
          cond do
            broker["id"] == 1 && broker["username"] == "test" -> true
            broker["id"] == 2 && broker["username"] == "test2" -> true
            true -> false
          end
        else
          is_successful
        end
      end
      assert is_successful == true
    end
  end

  test "exchange_clusters! - failure", context do
    use_cassette "exchange_clusters_failure", custom: true do
      brokers = OpenAperture.ManagerApi.MessagingExchange.exchange_clusters!(context[:api], 1)
      assert brokers == nil
    end
  end

  test "exchange_has_modules_of_type - success", context do
    use_cassette "list_modules_with_build", custom: true do
      assert OpenAperture.ManagerApi.MessagingExchange.exchange_has_modules_of_type?(context[:api], 1, "build")
    end
  end

  test "exchange_has_modules_of_type - failure", context do
    use_cassette "list_modules_without_build", custom: true do
      refute OpenAperture.ManagerApi.MessagingExchange.exchange_has_modules_of_type?(context[:api], 1, "build")
    end
  end

end