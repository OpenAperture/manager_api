defmodule CloudOS.ManagerAPI.MessagingBrokerTest do
  use ExUnit.Case
  use ExVCR.Mock, adapter: ExVCR.Adapter.Httpc, options: [clear_mock: true]

  alias CloudOS.ManagerAPI.Response

  setup do
    api = CloudOS.ManagerAPI.create!(%{url: "https://cloudos-mgr.host.co", client_id: "id", client_secret: "secret"})

    {:ok, [
      api: api
    ]}
  end    

  # =============================
  # list tests

  test "supervised list - success", context do
    use_cassette "list_brokers", custom: true do
      response = CloudOS.ManagerAPI.MessagingBroker.list
      assert response != nil
      assert response.success? == true
      assert response.status == 200

      brokers = response.body
      assert brokers != nil
      assert length(brokers) == 2
      is_successful = Enum.reduce brokers, true, fn (broker, is_successful) ->
        if is_successful do
          cond do
            broker["id"] == 1 && broker["name"] == "test broker" -> true
            broker["id"] == 2 && broker["name"] == "second broker" -> true
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
    use_cassette "list_brokers", custom: true do
      response = CloudOS.ManagerAPI.MessagingBroker.list(context[:api])
      assert response != nil
      assert response.success? == true
      assert response.status == 200

      brokers = response.body
      assert brokers != nil
      assert length(brokers) == 2
      is_successful = Enum.reduce brokers, true, fn (broker, is_successful) ->
        if is_successful do
          cond do
            broker["id"] == 1 && broker["name"] == "test broker" -> true
            broker["id"] == 2 && broker["name"] == "second broker" -> true
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
    use_cassette "list_brokers_failure", custom: true do
      response = CloudOS.ManagerAPI.MessagingBroker.list(context[:api])
      assert response != nil
      assert response.success? == false
      assert response.status == 401
    end
  end

  # =============================
  # list! tests

  test "list! - success", context do
    use_cassette "list_brokers", custom: true do
      brokers = CloudOS.ManagerAPI.MessagingBroker.list!(context[:api])
      assert brokers != nil
      assert length(brokers) == 2
      is_successful = Enum.reduce brokers, true, fn (broker, is_successful) ->
        if is_successful do
          cond do
            broker["id"] == 1 && broker["name"] == "test broker" -> true
            broker["id"] == 2 && broker["name"] == "second broker" -> true
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
    use_cassette "list_brokers_failure", custom: true do
      brokers = CloudOS.ManagerAPI.MessagingBroker.list!(context[:api])
      assert brokers == nil
    end
  end

  # =============================
  # get_broker tests

  test "supervised get_broker - success", context do
    use_cassette "get_broker", custom: true do
      response = CloudOS.ManagerAPI.MessagingBroker.get_broker(1)
      assert response != nil
      assert response.success? == true
      assert response.status == 200

      broker = response.body
      assert broker != nil
      assert broker["id"] == 1 
      assert broker["name"] == "test broker"
    end
  end

  test "get_broker - success", context do
    use_cassette "get_broker", custom: true do
      response = CloudOS.ManagerAPI.MessagingBroker.get_broker(context[:api], 1)
      assert response != nil
      assert response.success? == true
      assert response.status == 200

      broker = response.body
      assert broker != nil
      assert broker["id"] == 1 
      assert broker["name"] == "test broker"
    end
  end

  test "get_broker - failure", context do
    use_cassette "get_broker_failure", custom: true do
      response = CloudOS.ManagerAPI.MessagingBroker.get_broker(context[:api], 1)
      assert response != nil
      assert response.success? == false
      assert response.status == 401
    end
  end

  # =============================
  # get_broker! tests

  test "get_broker! - success", context do
    use_cassette "get_broker", custom: true do
      broker = CloudOS.ManagerAPI.MessagingBroker.get_broker!(context[:api], 1)
      assert broker != nil
      assert broker["id"] == 1 
      assert broker["name"] == "test broker"
    end
  end

  test "get_broker! - failure", context do
    use_cassette "get_broker_failure", custom: true do
      broker = CloudOS.ManagerAPI.MessagingBroker.get_broker!(context[:api], 1)
      assert broker == nil
    end
  end

  # =============================
  # create_broker tests

  test "supervised create_broker - success", context do
    use_cassette "create_broker", custom: true do
      response = CloudOS.ManagerAPI.MessagingBroker.create_broker(%{name: "test broker"})
      assert response != nil
      assert response.success? == true
      assert response.status == 201
      assert Response.extract_identifier_from_location_header(response) == "1"
    end
  end

  test "create_broker - success", context do
    use_cassette "create_broker", custom: true do
      response = CloudOS.ManagerAPI.MessagingBroker.create_broker(context[:api], %{name: "test broker"})
      assert response != nil
      assert response.success? == true
      assert response.status == 201
      assert Response.extract_identifier_from_location_header(response) == "1"
    end
  end

  test "create_broker - failure", context do
    use_cassette "create_broker_failure", custom: true do
      response = CloudOS.ManagerAPI.MessagingBroker.create_broker(context[:api], %{name: "test broker"})
      assert response != nil
      assert response.success? == false
      assert response.status == 400
    end
  end

  # =============================
  # create_broker! tests

  test "create_broker! - success", context do
    use_cassette "create_broker", custom: true do
      broker_id = CloudOS.ManagerAPI.MessagingBroker.create_broker!(context[:api], %{name: "test broker"})
      assert broker_id != nil
      assert broker_id == "1"
    end
  end

  test "create_broker! - failure", context do
    use_cassette "create_broker_failure", custom: true do
      broker_id = CloudOS.ManagerAPI.MessagingBroker.create_broker!(context[:api], %{name: "test broker"})
      assert broker_id == nil
    end
  end

  # =============================
  # update_broker tests

  test "supervised update_broker - success", context do
    use_cassette "update_broker", custom: true do
      response = CloudOS.ManagerAPI.MessagingBroker.update_broker(1, %{name: "test broker"})
      assert response != nil
      assert response.success? == true
      assert response.status == 204
      assert Response.extract_identifier_from_location_header(response) == "1"
    end
  end

  test "update_broker - success", context do
    use_cassette "update_broker", custom: true do
      response = CloudOS.ManagerAPI.MessagingBroker.update_broker(context[:api], 1, %{name: "test broker"})
      assert response != nil
      assert response.success? == true
      assert response.status == 204
      assert Response.extract_identifier_from_location_header(response) == "1"
    end
  end

  test "update_broker - failure", context do
    use_cassette "update_broker_failure", custom: true do
      response = CloudOS.ManagerAPI.MessagingBroker.update_broker(context[:api], 1, %{name: "test broker"})
      assert response != nil
      assert response.success? == false
      assert response.status == 401
    end
  end

  # =============================
  # update_broker! tests

  test "update_broker! - success", context do
    use_cassette "update_broker", custom: true do
      broker_id = CloudOS.ManagerAPI.MessagingBroker.update_broker!(context[:api], 1, %{name: "test broker"})
      assert broker_id != nil
      assert broker_id == "1"
    end
  end

  test "update_broker! - failure", context do
    use_cassette "update_broker_failure", custom: true do
      broker_id = CloudOS.ManagerAPI.MessagingBroker.update_broker!(context[:api], 1, %{name: "test broker"})
      assert broker_id == nil
    end
  end  

  # =============================
  # delete_broker tests

  test "supervised delete_broker - success", context do
    use_cassette "delete_broker", custom: true do
      response = CloudOS.ManagerAPI.MessagingBroker.delete_broker(1)
      assert response != nil
      assert response.success? == true
      assert response.status == 204
    end
  end

  test "delete_broker - success", context do
    use_cassette "delete_broker", custom: true do
      response = CloudOS.ManagerAPI.MessagingBroker.delete_broker(context[:api], 1)
      assert response != nil
      assert response.success? == true
      assert response.status == 204
    end
  end

  test "delete_broker - failure", context do
    use_cassette "delete_broker_failure", custom: true do
      response = CloudOS.ManagerAPI.MessagingBroker.delete_broker(context[:api], 1)
      assert response != nil
      assert response.success? == false
      assert response.status == 401
    end
  end

  # =============================
  # delete_broker! tests

  test "delete_broker! - success", context do
    use_cassette "delete_broker", custom: true do
      broker_id = CloudOS.ManagerAPI.MessagingBroker.delete_broker!(context[:api], 1)
      assert broker_id != nil
      assert broker_id == true
    end
  end

  test "delete_broker! - failure", context do
    use_cassette "delete_broker_failure", custom: true do
      broker_id = CloudOS.ManagerAPI.MessagingBroker.delete_broker!(context[:api], 1)
      assert broker_id == false
    end
  end  

  # =============================
  # create_broker_connection tests

  test "supervised create_broker_connection - success", context do
    use_cassette "create_broker_connection", custom: true do
      response = CloudOS.ManagerAPI.MessagingBroker.create_broker_connection(1, %{name: "test broker"})
      assert response != nil
      assert response.success? == true
      assert response.status == 201
    end
  end

  test "create_broker_connection - success", context do
    use_cassette "create_broker_connection", custom: true do
      response = CloudOS.ManagerAPI.MessagingBroker.create_broker_connection(context[:api], 1, %{name: "test broker"})
      assert response != nil
      assert response.success? == true
      assert response.status == 201
    end
  end

  test "create_broker_connection - failure", context do
    use_cassette "create_broker_failure", custom: true do
      response = CloudOS.ManagerAPI.MessagingBroker.create_broker_connection(context[:api], 1, %{name: "test broker"})
      assert response != nil
      assert response.success? == false
      assert response.status == 400
    end
  end

  # =============================
  # create_broker_connection! tests

  test "create_broker_connection! - success", context do
    use_cassette "create_broker_connection", custom: true do
      broker_id = CloudOS.ManagerAPI.MessagingBroker.create_broker_connection!(context[:api], 1, %{name: "test broker"})
      assert broker_id != nil
      assert broker_id == true
    end
  end

  test "create_broker_connection! - failure", context do
    use_cassette "create_broker_failure", custom: true do
      broker_id = CloudOS.ManagerAPI.MessagingBroker.create_broker_connection!(context[:api], 1, %{name: "test broker"})
      assert broker_id == false
    end
  end

  # =============================
  # broker_connections tests

  test "supervised broker_connections - success", context do
    use_cassette "get_broker_connections", custom: true do
      response = CloudOS.ManagerAPI.MessagingBroker.broker_connections(1)
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

  test "broker_connections - success", context do
    use_cassette "get_broker_connections", custom: true do
      response = CloudOS.ManagerAPI.MessagingBroker.broker_connections(context[:api], 1)
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

  test "broker_connections - failure", context do
    use_cassette "get_broker_connections_failure", custom: true do
      response = CloudOS.ManagerAPI.MessagingBroker.broker_connections(context[:api], 1)
      assert response != nil
      assert response.success? == false
      assert response.status == 401
    end
  end

  # =============================
  # broker_connections! tests

  test "broker_connections! - success", context do
    use_cassette "get_broker_connections", custom: true do
      brokers = CloudOS.ManagerAPI.MessagingBroker.broker_connections!(context[:api], 1)
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

  test "broker_connections! - failure", context do
    use_cassette "get_broker_connections_failure", custom: true do
      brokers = CloudOS.ManagerAPI.MessagingBroker.broker_connections!(context[:api], 1)
      assert brokers == nil
    end
  end



  # =============================
  # delete_broker_connections tests

  test "supervised delete_broker_connections - success", context do
    use_cassette "delete_broker_connections", custom: true do
      response = CloudOS.ManagerAPI.MessagingBroker.delete_broker_connections(1)
      assert response != nil
      assert response.success? == true
      assert response.status == 204
    end
  end

  test "delete_broker_connections - success", context do
    use_cassette "delete_broker_connections", custom: true do
      response = CloudOS.ManagerAPI.MessagingBroker.delete_broker_connections(context[:api], 1)
      assert response != nil
      assert response.success? == true
      assert response.status == 204
    end
  end

  test "delete_broker_connections - failure", context do
    use_cassette "delete_broker_connections_failure", custom: true do
      response = CloudOS.ManagerAPI.MessagingBroker.delete_broker_connections(context[:api], 1)
      assert response != nil
      assert response.success? == false
      assert response.status == 401
    end
  end

  # =============================
  # delete_broker_connections! tests

  test "delete_broker_connections! - success", context do
    use_cassette "delete_broker_connections", custom: true do
      broker_id = CloudOS.ManagerAPI.MessagingBroker.delete_broker_connections!(context[:api], 1)
      assert broker_id != nil
      assert broker_id == true
    end
  end

  test "delete_broker_connections! - failure", context do
    use_cassette "delete_broker_connections_failure", custom: true do
      broker_id = CloudOS.ManagerAPI.MessagingBroker.delete_broker_connections!(context[:api], 1)
      assert broker_id == false
    end
  end 
end