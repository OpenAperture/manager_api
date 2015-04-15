defmodule OpenAperture.ManagerApi.ProductDeploymentPlan.Test do
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

  test "list deployment plans", context do
    use_cassette "products/product_deployment_plan/list_deployment_plans" do
      response = OpenAperture.ManagerApi.ProductDeploymentPlan.list(context[:api], context[:product])

      assert response.status == 200
      assert length(response.body) == 2
    end
  end

  test "list! deployment plans", context do
    use_cassette "products/product_deployment_plan/list_deployment_plans" do
      response = OpenAperture.ManagerApi.ProductDeploymentPlan.list!(context[:api], context[:product])

      assert length(response) == 2
    end
  end

  test "get deployment plan", context do
    use_cassette "products/product_deployment_plan/get_deployment_plan" do
      response = OpenAperture.ManagerApi.ProductDeploymentPlan.get_deployment_plan(context[:api], context[:product], "test_deployment_plan")

      assert response.status == 200
      assert response.body["name"] == "test_deployment_plan"
    end
  end

  test "get! deployment plan", context do
    use_cassette "products/product_deployment_plan/get_deployment_plan" do
      response = OpenAperture.ManagerApi.ProductDeploymentPlan.get_deployment_plan!(context[:api], context[:product], "test_deployment_plan")

      assert response["name"] == "test_deployment_plan"
    end
  end

  test "create deployment plan", context do
    use_cassette "products/product_deployment_plan/create_deployment_plan" do
      response = OpenAperture.ManagerApi.ProductDeploymentPlan.create_deployment_plan(context[:api], context[:product], %{name: "test_deployment_plan"})

      assert response.status == 201
      assert List.keymember?(response.headers, "location", 0)
      {_, location} = List.keyfind(response.headers, "location", 0)
      assert "/products/jordans_test_product/deployment_plans/test_deployment_plan" == location
    end
  end

  test "create! deployment plan", context do
    use_cassette "products/product_deployment_plan/create_deployment_plan" do
      response = OpenAperture.ManagerApi.ProductDeploymentPlan.create_deployment_plan!(context[:api], context[:product], %{name: "test_deployment_plan"})

      assert response == "test_deployment_plan"
    end
  end

  test "update deployment plan", context do
    use_cassette "products/product_deployment_plan/update_deployment_plan" do
      updated_plan = %{name: "test_deployment_plan_updated"}
      response = OpenAperture.ManagerApi.ProductDeploymentPlan.update_deployment_plan(context[:api], context[:product], "test_deployment_plan", updated_plan)

      assert response.status == 204
      assert List.keymember?(response.headers, "location", 0)
      {_, location} = List.keyfind(response.headers, "location", 0)
      assert "/products/jordans_test_product/deployment_plans/test_deployment_plan_updated" == location
    end
  end

  test "update! deployment plan", context do
    use_cassette "products/product_deployment_plan/update_deployment_plan" do
      updated_plan = %{name: "test_deployment_plan_updated"}
      response = OpenAperture.ManagerApi.ProductDeploymentPlan.update_deployment_plan!(context[:api], context[:product], "test_deployment_plan", updated_plan)

      assert response == "test_deployment_plan_updated"
    end
  end

  test "delete deployment plan", context do
    use_cassette "products/product_deployment_plan/delete_deployment_plan" do
      response = OpenAperture.ManagerApi.ProductDeploymentPlan.delete_deployment_plan(context[:api], context[:product], "test_deployment_plan_updated")

      assert response.status == 204
    end
  end

  test "delete! deployment plan", context do
    use_cassette "products/product_deployment_plan/delete_deployment_plan" do
      response = OpenAperture.ManagerApi.ProductDeploymentPlan.delete_deployment_plan!(context[:api], context[:product], "test_deployment_plan_updated")

      assert response == true
    end
  end

  test "delete all deployment plans", context do
    use_cassette "products/product_deployment_plan/delete_all_deployment_plans" do
      response = OpenAperture.ManagerApi.ProductDeploymentPlan.delete_all_deployment_plans(context[:api], context[:product])

      assert response.status == 204
    end
  end

  test "delete all! deployment plans", context do
    use_cassette "products/product_deployment_plan/delete_all_deployment_plans" do
      response = OpenAperture.ManagerApi.ProductDeploymentPlan.delete_all_deployment_plans!(context[:api], context[:product])

      assert response == true
    end
  end
  
end