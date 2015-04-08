defmodule CloudOS.ManagerAPI.ProductEnvironment.Test do
  use ExUnit.Case, async: false
  use ExVCR.Mock, adapter: ExVCR.Adapter.Httpc, options: [clear_mock: true]

  setup_all do
    :meck.new(CloudosAuth.Client, [:passthrough])
    :meck.expect(CloudosAuth.Client, :get_token, fn _, _, _ -> "abc" end)

    on_exit fn -> :meck.unload end
  end

  setup do
    api = CloudOS.ManagerAPI.create!(%{
      manager_url: "http://localhost",
      oauth_login_url: "https://localhost/oauth/token",
      oauth_client_id: "test_id",
      oauth_client_secret: "test_secret"
      })

    {:ok, api: api}
  end

  test "list environments", context do
    use_cassette "products/product_environment/list_environments", custom: true do
      response = CloudOS.ManagerAPI.ProductEnvironment.list(context[:api], "jordans_test_product")
      assert response.status == 200
      assert length(response.body) == 3
    end
  end

  test "list! environments", context do
    use_cassette "products/product_environment/list_environments", custom: true do
      response = CloudOS.ManagerAPI.ProductEnvironment.list!(context[:api], "jordans_test_product")
      assert length(response) == 3
    end
  end

  test "get environment", context do
    use_cassette "products/product_environment/get_environment", custom: true do
      response = CloudOS.ManagerAPI.ProductEnvironment.get_environment(context[:api], "jordans_test_product", "testing")
      assert response.status == 200
      assert response.body["name"] == "testing"
    end
  end

  test "get! environment", context do
    use_cassette "products/product_environment/get_environment", custom: true do
      response = CloudOS.ManagerAPI.ProductEnvironment.get_environment!(context[:api], "jordans_test_product", "testing")
      assert response["name"] == "testing"
    end
  end

  test "create environment", context do
    use_cassette "products/product_environment/create_environment", custom: true do
      environment = %{name: "new_test_environment"}
      response = CloudOS.ManagerAPI.ProductEnvironment.create_environment(context[:api], "jordans_test_product", environment)
      assert response.status == 201
      assert List.keymember?(response.headers, "location", 0)
      {_, location} = List.keyfind(response.headers, "location", 0)
      assert "/products/jordans_test_product/environments/new_test_environment" == location
    end
  end

  test "create! environment", context do
    use_cassette "products/product_environment/create_environment", custom: true do
      environment = %{name: "new_test_environment"}
      response = CloudOS.ManagerAPI.ProductEnvironment.create_environment!(context[:api], "jordans_test_product", environment)
      assert response == "new_test_environment"
    end
  end

  test "update environment", context do
    use_cassette "products/product_environment/update_environment", custom: true do
      updated_environment = %{name: "updated_test_environment"}
      response = CloudOS.ManagerAPI.ProductEnvironment.update_environment(context[:api], "jordans_test_product", "new_test_environment", updated_environment)
      assert response.status == 204
      assert List.keymember?(response.headers, "location", 0)
      {_, location} = List.keyfind(response.headers, "location", 0)
      assert "/products/jordans_test_product/environments/updated_test_environment" == location
    end
  end

  test "update! environment", context do
    use_cassette "products/product_environment/update_environment", custom: true do
      updated_environment = %{name: "updated_test_environment"}
      response = CloudOS.ManagerAPI.ProductEnvironment.update_environment!(context[:api], "jordans_test_product", "new_test_environment", updated_environment)
      assert response == "updated_test_environment"
    end
  end

  test "delete_environment", context do
    use_cassette "products/product_environment/delete_environment", custom: true do
      response = CloudOS.ManagerAPI.ProductEnvironment.delete_environment(context[:api], "jordans_test_product", "updated_test_environment")
      assert response.status == 204
    end
  end

  test "delete_environment!", context do
    use_cassette "products/product_environment/delete_environment", custom: true do
      response = CloudOS.ManagerAPI.ProductEnvironment.delete_environment!(context[:api], "jordans_test_product", "updated_test_environment")
      assert response == true
    end
  end
end