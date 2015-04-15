defmodule OpenAperture.ManagerApi.ProductDeployment.Test do
  use ExUnit.Case, async: false
  use ExVCR.Mock, adapter: ExVCR.Adapter.Httpc, options: [clear_mock: true]

  setup do
    api = OpenAperture.ManagerApi.create!(%{
      manager_url: "http://localhost",
      oauth_login_url: "https://localhost/oauth/token",
      oauth_client_id: "test_id",
      oauth_client_secret: "test_secret"
    })

    {:ok, api: api, product: "jordans_test_product", plan: "test_deployment_plan", plan_id: 3}
  end

  test "list deployments", context do
    use_cassette "products/product_deployment/list_deployments" do
      response = OpenAperture.ManagerApi.ProductDeployment.list(context[:api], context[:product])

      assert response.status == 200
      assert length(response.body) == 1
    end
  end

  test "list! deployments", context do
    use_cassette "products/product_deployment/list_deployments" do
      response = OpenAperture.ManagerApi.ProductDeployment.list!(context[:api], context[:product])

      assert length(response) == 1
    end
  end

  test "get deployment", context do
    use_cassette "products/product_deployment/get_deployment" do
      response = OpenAperture.ManagerApi.ProductDeployment.get_deployment(context[:api], context[:product], 1)

      assert response.status == 200
      assert response.body["product_deployment_plan_id"] == context[:plan_id]
    end
  end

  test "get! deployment", context do
    use_cassette "products/product_deployment/get_deployment" do
      response = OpenAperture.ManagerApi.ProductDeployment.get_deployment!(context[:api], context[:product], 1)

      assert response["product_deployment_plan_id"] == 3
    end
  end

  test "create deployment", context do
    use_cassette "products/product_deployment/create_deployment" do
      response = OpenAperture.ManagerApi.ProductDeployment.create_deployment(context[:api], context[:product], context[:plan], %{})

      assert response.status == 201
      assert List.keymember?(response.headers, "location", 0)
      {_, location} = List.keyfind(response.headers, "location", 0)
      assert "/products/jordans_test_product/deployments/1" == location
    end
  end

  test "create! deployment", context do
    use_cassette "products/product_deployment/create_deployment" do
      response = OpenAperture.ManagerApi.ProductDeployment.create_deployment!(context[:api], context[:product], context[:plan], %{})

      assert response == "1"
    end
  end

  test "delete deployment", context do
    use_cassette "products/product_deployment/delete_deployment" do
      response = OpenAperture.ManagerApi.ProductDeployment.delete_deployment(context[:api], context[:product], 1)

      assert response.status == 204
    end
  end

  test "delete! deployment", context do
    use_cassette "products/product_deployment/delete_deployment" do
      response = OpenAperture.ManagerApi.ProductDeployment.delete_deployment!(context[:api], context[:product], 1)

      assert response == true
    end
  end
end