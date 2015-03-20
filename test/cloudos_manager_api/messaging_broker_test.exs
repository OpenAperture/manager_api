defmodule CloudOS.ManagerAPI.MessagingBrokerTest do
  use ExUnit.Case
  use ExVCR.Mock, adapter: ExVCR.Adapter.Httpc, options: [clear_mock: true]

  setup do
    api = CloudOS.ManagerAPI.create!(%{url: "https://cloudos-mgr.host.co", client_id: "id", client_secret: "secret"})

    {:ok, [
      api: api
    ]}
  end    

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

  
end