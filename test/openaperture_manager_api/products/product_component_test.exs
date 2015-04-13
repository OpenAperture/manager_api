defmodule OpenAperture.ManagerApi.ProductComponent.Test do
  use ExUnit.Case, async: false
  use ExVCR.Mock, adapter: ExVCR.Adapter.Httpc, options: [clear_mock: true]

  setup do
    api = OpenAperture.ManagerApi.create!(%{
      manager_url: "http://localhost",
      oauth_login_url: "https://localhost/oauth/token",
      oauth_client_id: "test_id",
      oauth_client_secret: "test_secret"
    })

    {:ok, api: api, product: "jordans_test_product"}
  end

  test "list components", context do
    use_cassette "products/product_component/list_components" do
      response = OpenAperture.ManagerApi.ProductComponent.list(context[:api], context[:product])

      assert response.status == 200
      assert length(response.body) == 2
    end
  end

  test "list! components", context do
    use_cassette "products/product_component/list_components" do
      response = OpenAperture.ManagerApi.ProductComponent.list!(context[:api], context[:product])

      assert length(response) == 2
    end
  end

  test "get component", context do
    use_cassette "products/product_component/get_component" do
      response = OpenAperture.ManagerApi.ProductComponent.get_component(context[:api], context[:product], "test_web_server_1")

      assert response.status == 200
      assert response.body["name"] == "test_web_server_1"
      assert response.body["type"] == "web_server"
      assert length(response.body["options"]) == 1
    end
  end

  test "get! component", context do
    use_cassette "products/product_component/get_component" do
      response = OpenAperture.ManagerApi.ProductComponent.get_component!(context[:api], context[:product], "test_web_server_1")

      assert response["name"] == "test_web_server_1"
      assert response["type"] == "web_server"
      assert length(response["options"]) == 1
    end
  end

  test "create component", context do
    use_cassette "products/product_component/create_component" do
      component = %{
        name: "test_database_1",
        type: "db",
        options: [
          %{name: "db_type", value: "postgresql"},
          %{name: "size", value: "huge"}]}

      response = OpenAperture.ManagerApi.ProductComponent.create_component(context[:api], context[:product], component)

      assert response.status == 201
      assert List.keymember?(response.headers, "location", 0)
      {_, location} = List.keyfind(response.headers, "location", 0)
      assert "/products/jordans_test_product/components/test_database_1" == location
    end
  end

  test "create! component", context do
    use_cassette "products/product_component/create_component" do
      component = %{
        name: "test_database_1",
        type: "db",
        options: [
          %{name: "db_type", value: "postgresql"},
          %{name: "size", value: "huge"}]}

      response = OpenAperture.ManagerApi.ProductComponent.create_component!(context[:api], context[:product], component)

      assert response == "test_database_1"
    end
  end

  test "update component", context do
    use_cassette "products/product_component/update_component" do
      updated_component = %{
        name: "test_database_1_updated",
        type: "db",
        options: [
          %{name: "db_type", value: "oracle"},
          %{name: "price", value: "very expensive"}]
      }

      response = OpenAperture.ManagerApi.ProductComponent.update_component(context[:api], context[:product], "test_database_1", updated_component)
      
      assert response.status == 204
      assert List.keymember?(response.headers, "location", 0)
      {_, location} = List.keyfind(response.headers, "location", 0)
      assert "/products/jordans_test_product/components/test_database_1_updated" == location
    end
  end

  test "update! component", context do
    use_cassette "products/product_component/update_component" do
      updated_component = %{
        name: "test_database_1_updated",
        type: "db",
        options: [
          %{name: "db_type", value: "oracle"},
          %{name: "price", value: "very expensive"}]
      }

      response = OpenAperture.ManagerApi.ProductComponent.update_component!(context[:api], context[:product], "test_database_1", updated_component)

      assert response == "test_database_1_updated"
    end
  end

  test "delete component", context do
    use_cassette "products/product_component/delete_component" do
      response = OpenAperture.ManagerApi.ProductComponent.delete_component(context[:api], context[:product], "test_database_1_updated")

      assert response.status == 204
    end
  end

  test "delete! component", context do
    use_cassette "products/product_component/delete_component" do
      response = OpenAperture.ManagerApi.ProductComponent.delete_component!(context[:api], context[:product], "test_database_1_updated")

      assert response == true
    end
  end

  test "delete all components", context do
    use_cassette "products/product_component/delete_all_components" do
      response = OpenAperture.ManagerApi.ProductComponent.delete_all_components(context[:api], context[:product])

      assert response.status == 204
    end
  end

  test "delete all! components", context do
    use_cassette "products/product_component/delete_all_components" do
      response = OpenAperture.ManagerApi.ProductComponent.delete_all_components!(context[:api], context[:product])

      assert response == true
    end
  end
  
end