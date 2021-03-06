defmodule OpenAperture.ManagerApi.Product.Test do
  use ExUnit.Case, async: false
  use ExVCR.Mock, adapter: ExVCR.Adapter.Httpc, options: [clear_mock: true]

  setup_all do
    :meck.new(OpenAperture.Auth.Client, [:passthrough])
    :meck.expect(OpenAperture.Auth.Client, :get_token, fn _, _, _ -> "abc" end)

    on_exit fn -> :meck.unload end
  end

  setup do
    api = OpenAperture.ManagerApi.create!(%{
      manager_url: "http://localhost",
      oauth_login_url: "https://localhost/oauth/token",
      oauth_client_id: "test_id",
      oauth_client_secret: "test_secret"
      })

    {:ok, api: api}
  end

  test "list products", context do
    use_cassette "products/product/list_products", custom: true do
      response = OpenAperture.ManagerApi.Product.list(context[:api])
      assert response.status == 200
      assert length(response.body) == 3
    end
  end

  test "list! products", context do
    use_cassette "products/product/list_products", custom: true do
      response = OpenAperture.ManagerApi.Product.list!(context[:api])
      assert length(response) == 3
    end
  end

  test "create product", context do
    use_cassette "products/product/create_product", custom: true do
      product = %{name: "Test product 123"}
      response = OpenAperture.ManagerApi.Product.create_product(context[:api], product)
      assert response.status == 201
      
      assert List.keymember?(response.headers, "location", 0)
      {_, location} = List.keyfind(response.headers, "location", 0)
      assert "/products/Test%20product%20123" == location
    end
  end

  test "create! product", context do
    use_cassette "products/product/create_product", custom: true do
      product = %{name: "Test product 123"}
      response = OpenAperture.ManagerApi.Product.create_product!(context[:api], product)
      assert response == "Test%20product%20123"
    end
  end

  test "get product", context do
    use_cassette "products/product/get_product", custom: true do
      response = OpenAperture.ManagerApi.Product.get_product(context[:api], URI.encode("Test product 123"))
      assert response.status == 200
      assert response.body["name"] == "Test product 123"
    end
  end

  test "get! product", context do
    use_cassette "products/product/get_product", custom: true do
      response = OpenAperture.ManagerApi.Product.get_product!(context[:api], URI.encode("Test product 123"))
      assert response["name"] == "Test product 123"
    end
  end

  test "update product", context do
    use_cassette "products/product/update_product", custom: true do
      updated_product = %{name: "Test product 123 updated"}
      response = OpenAperture.ManagerApi.Product.update_product(context[:api], URI.encode("Test product 123"), updated_product)
      assert response.status == 204
      assert List.keymember?(response.headers, "location", 0)
      {_, location} = List.keyfind(response.headers, "location", 0)
      assert "/products/Test%20product%20123%20updated" == location
    end
  end

  test "update! product", context do
    use_cassette "products/product/update_product", custom: true do
      updated_product = %{name: "Test product 123 updated"}
      response = OpenAperture.ManagerApi.Product.update_product!(context[:api], URI.encode("Test product 123"), updated_product)
      assert response == "Test%20product%20123%20updated"
    end
  end

  test "delete product", context do
    use_cassette "products/product/delete_product", custom: true do
      response = OpenAperture.ManagerApi.Product.delete_product(context[:api], URI.encode("Test product 123 updated"))
      assert response.status == 204
    end
  end

  test "delete! product", context do
    use_cassette "products/product/delete_product", custom: true do
      response = OpenAperture.ManagerApi.Product.delete_product!(context[:api], URI.encode("Test product 123 updated"))
      assert response == true
    end
  end
end