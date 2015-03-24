defmodule CloudOS.ManagerAPI.EtcdClusterTest do
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
    use_cassette "list_clusters", custom: true do
      response = CloudOS.ManagerAPI.EtcdCluster.list
      assert response != nil
      assert response.success? == true
      assert response.status == 200

      brokers = response.body
      assert brokers != nil
      assert length(brokers) == 2
      is_successful = Enum.reduce brokers, true, fn (broker, is_successful) ->
        if is_successful do
          cond do
            broker["id"] == 1 && broker["etcd_token"] == "123abc" -> true
            broker["id"] == 2 && broker["etcd_token"] == "789xyz" -> true
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
    use_cassette "list_clusters", custom: true do
      response = CloudOS.ManagerAPI.EtcdCluster.list(context[:api])
      assert response != nil
      assert response.success? == true
      assert response.status == 200

      brokers = response.body
      assert brokers != nil
      assert length(brokers) == 2
      is_successful = Enum.reduce brokers, true, fn (broker, is_successful) ->
        if is_successful do
          cond do
            broker["id"] == 1 && broker["etcd_token"] == "123abc" -> true
            broker["id"] == 2 && broker["etcd_token"] == "789xyz" -> true
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
    use_cassette "list_clusters_failure", custom: true do
      response = CloudOS.ManagerAPI.EtcdCluster.list(context[:api])
      assert response != nil
      assert response.success? == false
      assert response.status == 401
    end
  end

  # =============================
  # list! tests

  test "list! - success", context do
    use_cassette "list_clusters", custom: true do
      brokers = CloudOS.ManagerAPI.EtcdCluster.list!(context[:api])
      assert brokers != nil
      assert length(brokers) == 2
      is_successful = Enum.reduce brokers, true, fn (broker, is_successful) ->
        if is_successful do
          cond do
            broker["id"] == 1 && broker["etcd_token"] == "123abc" -> true
            broker["id"] == 2 && broker["etcd_token"] == "789xyz" -> true
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
    use_cassette "list_clusters_failure", custom: true do
      brokers = CloudOS.ManagerAPI.EtcdCluster.list!(context[:api])
      assert brokers == nil
    end
  end

  # =============================
  # get_cluster tests

  test "supervised get_cluster - success", context do
    use_cassette "get_cluster", custom: true do
      response = CloudOS.ManagerAPI.EtcdCluster.get_cluster("123abc")
      assert response != nil
      assert response.success? == true
      assert response.status == 200

      broker = response.body
      assert broker != nil
      assert broker["etcd_token"] == "123abc"
    end
  end

  test "get_cluster - success", context do
    use_cassette "get_cluster", custom: true do
      response = CloudOS.ManagerAPI.EtcdCluster.get_cluster(context[:api], "123abc")
      assert response != nil
      assert response.success? == true
      assert response.status == 200

      broker = response.body
      assert broker != nil
      assert broker["etcd_token"] == "123abc"
    end
  end

  test "get_cluster - failure", context do
    use_cassette "get_cluster_failure", custom: true do
      response = CloudOS.ManagerAPI.EtcdCluster.get_cluster(context[:api], "123abc")
      assert response != nil
      assert response.success? == false
      assert response.status == 401
    end
  end

  # =============================
  # get_cluster! tests

  test "get_cluster! - success", context do
    use_cassette "get_cluster", custom: true do
      broker = CloudOS.ManagerAPI.EtcdCluster.get_cluster!(context[:api], "123abc")
      assert broker != nil
      assert broker["etcd_token"] == "123abc"
    end
  end

  test "get_cluster! - failure", context do
    use_cassette "get_cluster_failure", custom: true do
      broker = CloudOS.ManagerAPI.EtcdCluster.get_cluster!(context[:api], "123abc")
      assert broker == nil
    end
  end

  # =============================
  # create_cluster tests

  test "supervised create_cluster - success", context do
    use_cassette "create_cluster", custom: true do
      response = CloudOS.ManagerAPI.EtcdCluster.create_cluster(%{etcd_token: "123abc"})
      assert response != nil
      assert response.success? == true
      assert response.status == 201
      assert Response.extract_identifier_from_location_header(response) == "123abc"
    end
  end

  test "create_cluster - success", context do
    use_cassette "create_cluster", custom: true do
      response = CloudOS.ManagerAPI.EtcdCluster.create_cluster(context[:api], %{etcd_token: "123abc"})
      assert response != nil
      assert response.success? == true
      assert response.status == 201
      assert Response.extract_identifier_from_location_header(response) == "123abc"
    end
  end

  test "create_cluster - failure", context do
    use_cassette "create_cluster_failure", custom: true do
      response = CloudOS.ManagerAPI.EtcdCluster.create_cluster(context[:api], %{etcd_token: "123abc"})
      assert response != nil
      assert response.success? == false
      assert response.status == 400
    end
  end

  # =============================
  # create_cluster! tests

  test "create_cluster! - success", context do
    use_cassette "create_cluster", custom: true do
      token = CloudOS.ManagerAPI.EtcdCluster.create_cluster!(context[:api], %{etcd_token: "123abc"})
      assert token != nil
      assert token == "123abc"
    end
  end

  test "create_cluster! - failure", context do
    use_cassette "create_cluster_failure", custom: true do
      token = CloudOS.ManagerAPI.EtcdCluster.create_cluster!(context[:api], %{etcd_token: "123abc"})
      assert token == nil
    end
  end

  # =============================
  # delete_cluster tests

  test "supervised delete_cluster - success", context do
    use_cassette "delete_cluster", custom: true do
      response = CloudOS.ManagerAPI.EtcdCluster.delete_cluster("123abc")
      assert response != nil
      assert response.success? == true
      assert response.status == 204
    end
  end

  test "delete_cluster - success", context do
    use_cassette "delete_cluster", custom: true do
      response = CloudOS.ManagerAPI.EtcdCluster.delete_cluster(context[:api], "123abc")
      assert response != nil
      assert response.success? == true
      assert response.status == 204
    end
  end

  test "delete_cluster - failure", context do
    use_cassette "delete_cluster_failure", custom: true do
      response = CloudOS.ManagerAPI.EtcdCluster.delete_cluster(context[:api], "123abc")
      assert response != nil
      assert response.success? == false
      assert response.status == 401
    end
  end

  # =============================
  # delete_cluster! tests

  test "delete_cluster! - success", context do
    use_cassette "delete_cluster", custom: true do
      token = CloudOS.ManagerAPI.EtcdCluster.delete_cluster!(context[:api], "123abc")
      assert token != nil
      assert token == true
    end
  end

  test "delete_cluster! - failure", context do
    use_cassette "delete_cluster_failure", custom: true do
      token = CloudOS.ManagerAPI.EtcdCluster.delete_cluster!(context[:api], "123abc")
      assert token == false
    end
  end

  # =============================
  # get_cluster_products tests

  test "supervised get_cluster_products - success", context do
    use_cassette "get_cluster_products", custom: true do
      response = CloudOS.ManagerAPI.EtcdCluster.get_cluster_products("123abc")
      assert response != nil
      assert response.success? == true
      assert response.status == 200

      products = response.body
      assert products != nil
      assert length(products) == 2
      is_successful = Enum.reduce products, true, fn (product, is_successful) ->
        if is_successful do
          cond do
            product["id"] == 1 && product["name"] == "test product" -> true
            product["id"] == 2 && product["name"] == "second product" -> true
            true -> false
          end
        else
          is_successful
        end
      end
      assert is_successful == true
    end
  end

  test "get_cluster_products - success", context do
    use_cassette "get_cluster_products", custom: true do
      response = CloudOS.ManagerAPI.EtcdCluster.get_cluster_products(context[:api], "123abc")
      assert response != nil
      assert response.success? == true
      assert response.status == 200

      products = response.body
      assert products != nil
      assert length(products) == 2
      is_successful = Enum.reduce products, true, fn (product, is_successful) ->
        if is_successful do
          cond do
            product["id"] == 1 && product["name"] == "test product" -> true
            product["id"] == 2 && product["name"] == "second product" -> true
            true -> false
          end
        else
          is_successful
        end
      end
      assert is_successful == true
    end
  end

  test "get_cluster_products - failure", context do
    use_cassette "get_cluster_products_failure", custom: true do
      response = CloudOS.ManagerAPI.EtcdCluster.get_cluster_products(context[:api], "123abc")
      assert response != nil
      assert response.success? == false
      assert response.status == 401
    end
  end

  # =============================
  # get_cluster_products! tests

  test "get_cluster_products! - success", context do
    use_cassette "get_cluster_products", custom: true do
      products = CloudOS.ManagerAPI.EtcdCluster.get_cluster_products!(context[:api], "123abc")
      assert products != nil
      assert length(products) == 2
      is_successful = Enum.reduce products, true, fn (product, is_successful) ->
        if is_successful do
          cond do
            product["id"] == 1 && product["name"] == "test product" -> true
            product["id"] == 2 && product["name"] == "second product" -> true
            true -> false
          end
        else
          is_successful
        end
      end
      assert is_successful == true
    end
  end

  test "get_cluster_products! - failure", context do
    use_cassette "get_cluster_products_failure", custom: true do
      broker = CloudOS.ManagerAPI.EtcdCluster.get_cluster_products!(context[:api], "123abc")
      assert broker == nil
    end
  end

  # =============================
  # get_cluster_machines tests

  test "supervised get_cluster_machines - success", context do
    use_cassette "get_cluster_machines", custom: true do
      response = CloudOS.ManagerAPI.EtcdCluster.get_cluster_machines("123abc")
      assert response != nil
      assert response.success? == true
      assert response.status == 200

      machines = response.body
      assert machines != nil
      assert length(machines) == 2
      is_successful = Enum.reduce machines, true, fn (machine, is_successful) ->
        if is_successful do
          cond do
            machine["id"] == 1 && machine["primaryIP"] == "123.234.456.789" -> true
            machine["id"] == 2 && machine["primaryIP"] == "000.000.000.000" -> true
            true -> false
          end
        else
          is_successful
        end
      end
      assert is_successful == true
    end
  end

  test "get_cluster_machines - success", context do
    use_cassette "get_cluster_machines", custom: true do
      response = CloudOS.ManagerAPI.EtcdCluster.get_cluster_machines(context[:api], "123abc")
      assert response != nil
      assert response.success? == true
      assert response.status == 200

      machines = response.body
      assert machines != nil
      assert length(machines) == 2
      is_successful = Enum.reduce machines, true, fn (machine, is_successful) ->
        if is_successful do
          cond do
            machine["id"] == 1 && machine["primaryIP"] == "123.234.456.789" -> true
            machine["id"] == 2 && machine["primaryIP"] == "000.000.000.000" -> true
            true -> false
          end
        else
          is_successful
        end
      end
      assert is_successful == true
    end
  end

  test "get_cluster_machines - failure", context do
    use_cassette "get_cluster_machines_failure", custom: true do
      response = CloudOS.ManagerAPI.EtcdCluster.get_cluster_machines(context[:api], "123abc")
      assert response != nil
      assert response.success? == false
      assert response.status == 401
    end
  end

  # =============================
  # get_cluster_machines! tests

  test "get_cluster_machines! - success", context do
    use_cassette "get_cluster_machines", custom: true do
      machines = CloudOS.ManagerAPI.EtcdCluster.get_cluster_machines!(context[:api], "123abc")
      assert machines != nil
      assert length(machines) == 2
      is_successful = Enum.reduce machines, true, fn (machine, is_successful) ->
        if is_successful do
          cond do
            machine["id"] == 1 && machine["primaryIP"] == "123.234.456.789" -> true
            machine["id"] == 2 && machine["primaryIP"] == "000.000.000.000" -> true
            true -> false
          end
        else
          is_successful
        end
      end
      assert is_successful == true
    end
  end

  test "get_cluster_machines! - failure", context do
    use_cassette "get_cluster_machines_failure", custom: true do
      machines = CloudOS.ManagerAPI.EtcdCluster.get_cluster_machines!(context[:api], "123abc")
      assert machines == nil
    end
  end

  # =============================
  # get_cluster_units tests

  test "supervised get_cluster_units - success", context do
    use_cassette "get_cluster_units", custom: true do
      response = CloudOS.ManagerAPI.EtcdCluster.get_cluster_units("123abc")
      assert response != nil
      assert response.success? == true
      assert response.status == 200

      units = response.body
      assert units != nil
      assert length(units) == 2
      is_successful = Enum.reduce units, true, fn (unit, is_successful) ->
        if is_successful do
          cond do
            unit["id"] == 1 && unit["name"] == "test unit" -> true
            unit["id"] == 2 && unit["name"] == "second unit" -> true
            true -> false
          end
        else
          is_successful
        end
      end
      assert is_successful == true
    end
  end

  test "get_cluster_units - success", context do
    use_cassette "get_cluster_units", custom: true do
      response = CloudOS.ManagerAPI.EtcdCluster.get_cluster_units(context[:api], "123abc")
      assert response != nil
      assert response.success? == true
      assert response.status == 200

      units = response.body
      assert units != nil
      assert length(units) == 2
      is_successful = Enum.reduce units, true, fn (unit, is_successful) ->
        if is_successful do
          cond do
            unit["id"] == 1 && unit["name"] == "test unit" -> true
            unit["id"] == 2 && unit["name"] == "second unit" -> true
            true -> false
          end
        else
          is_successful
        end
      end
      assert is_successful == true
    end
  end

  test "get_cluster_units - failure", context do
    use_cassette "get_cluster_units_failure", custom: true do
      response = CloudOS.ManagerAPI.EtcdCluster.get_cluster_units(context[:api], "123abc")
      assert response != nil
      assert response.success? == false
      assert response.status == 401
    end
  end

  # =============================
  # get_cluster_units! tests

  test "get_cluster_units! - success", context do
    use_cassette "get_cluster_units", custom: true do
      units = CloudOS.ManagerAPI.EtcdCluster.get_cluster_units!(context[:api], "123abc")
      assert units != nil
      assert length(units) == 2
      is_successful = Enum.reduce units, true, fn (unit, is_successful) ->
        if is_successful do
          cond do
            unit["id"] == 1 && unit["name"] == "test unit" -> true
            unit["id"] == 2 && unit["name"] == "second unit" -> true
            true -> false
          end
        else
          is_successful
        end
      end
      assert is_successful == true
    end
  end

  test "get_cluster_units! - failure", context do
    use_cassette "get_cluster_units_failure", custom: true do
      machines = CloudOS.ManagerAPI.EtcdCluster.get_cluster_units!(context[:api], "123abc")
      assert machines == nil
    end
  end

  # =============================
  # get_cluster_units_state tests

  test "supervised get_cluster_units_state - success", context do
    use_cassette "get_cluster_units_state", custom: true do
      response = CloudOS.ManagerAPI.EtcdCluster.get_cluster_units_state("123abc")
      assert response != nil
      assert response.success? == true
      assert response.status == 200

      units = response.body
      assert units != nil
      assert length(units) == 2
      is_successful = Enum.reduce units, true, fn (unit, is_successful) ->
        if is_successful do
          cond do
            unit["id"] == 1 && unit["name"] == "test unit" -> true
            unit["id"] == 2 && unit["name"] == "second unit" -> true
            true -> false
          end
        else
          is_successful
        end
      end
      assert is_successful == true
    end
  end

  test "get_cluster_units_state - success", context do
    use_cassette "get_cluster_units_state", custom: true do
      response = CloudOS.ManagerAPI.EtcdCluster.get_cluster_units_state(context[:api], "123abc")
      assert response != nil
      assert response.success? == true
      assert response.status == 200

      units = response.body
      assert units != nil
      assert length(units) == 2
      is_successful = Enum.reduce units, true, fn (unit, is_successful) ->
        if is_successful do
          cond do
            unit["id"] == 1 && unit["name"] == "test unit" -> true
            unit["id"] == 2 && unit["name"] == "second unit" -> true
            true -> false
          end
        else
          is_successful
        end
      end
      assert is_successful == true
    end
  end

  test "get_cluster_units_state - failure", context do
    use_cassette "get_cluster_units_state_failure", custom: true do
      response = CloudOS.ManagerAPI.EtcdCluster.get_cluster_units_state(context[:api], "123abc")
      assert response != nil
      assert response.success? == false
      assert response.status == 401
    end
  end

  # =============================
  # get_cluster_units_state! tests

  test "get_cluster_units_state! - success", context do
    use_cassette "get_cluster_units_state", custom: true do
      units = CloudOS.ManagerAPI.EtcdCluster.get_cluster_units_state!(context[:api], "123abc")
      assert units != nil
      assert length(units) == 2
      is_successful = Enum.reduce units, true, fn (unit, is_successful) ->
        if is_successful do
          cond do
            unit["id"] == 1 && unit["name"] == "test unit" -> true
            unit["id"] == 2 && unit["name"] == "second unit" -> true
            true -> false
          end
        else
          is_successful
        end
      end
      assert is_successful == true
    end
  end

  test "get_cluster_units_state! - failure", context do
    use_cassette "get_cluster_units_state_failure", custom: true do
      machines = CloudOS.ManagerAPI.EtcdCluster.get_cluster_units_state!(context[:api], "123abc")
      assert machines == nil
    end
  end

  # =============================
  # get_cluster_unit_log tests

  test "supervised get_cluster_unit_log - success", context do
    use_cassette "get_cluster_unit_log", custom: true do
      response = CloudOS.ManagerAPI.EtcdCluster.get_cluster_unit_log("123abc", 1, "testUnit")
      assert response != nil
      assert response.success? == true
      assert response.status == 200
      assert response.body == nil
      assert response.raw_body == "this is the log file content\nwhat new log is now"
    end
  end

  test "get_cluster_unit_log - success", context do
    use_cassette "get_cluster_unit_log", custom: true do
      response = CloudOS.ManagerAPI.EtcdCluster.get_cluster_unit_log(context[:api], "123abc", 1, "testUnit")
      assert response != nil
      assert response.success? == true
      assert response.status == 200
      assert response.body == nil
      assert response.raw_body == "this is the log file content\nwhat new log is now"
    end
  end

  test "get_cluster_unit_log - failure", context do
    use_cassette "get_cluster_unit_log_failure", custom: true do
      response = CloudOS.ManagerAPI.EtcdCluster.get_cluster_unit_log(context[:api], "123abc", 1, "testUnit")
      assert response != nil
      assert response.success? == false
      assert response.status == 401
    end
  end

  # =============================
  # get_cluster_unit_log! tests

  test "get_cluster_unit_log! - success", context do
    use_cassette "get_cluster_unit_log", custom: true do
      logs = CloudOS.ManagerAPI.EtcdCluster.get_cluster_unit_log!(context[:api], "123abc", 1, "testUnit")
      assert logs == "this is the log file content\nwhat new log is now"
    end
  end

  test "get_cluster_unit_log! - failure", context do
    use_cassette "get_cluster_unit_log_failure", custom: true do
      logs = CloudOS.ManagerAPI.EtcdCluster.get_cluster_unit_log!(context[:api], "123abc", 1, "testUnit")
      assert logs == nil
    end
  end
end