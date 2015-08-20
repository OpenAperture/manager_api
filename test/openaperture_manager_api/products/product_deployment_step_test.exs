defmodule OpenAperture.ManagerApi.ProductDeploymentStep.Test do
  use ExUnit.Case, async: false
  use ExVCR.Mock, adapter: ExVCR.Adapter.Httpc, options: [clear_mock: true]

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
    api = OpenAperture.ManagerApi.create!(%{
      manager_url: "https://openaperture-mgr.host.co",
      oauth_login_url: "https://localhost/oauth/token",
      oauth_client_id: "test_id",
      oauth_client_secret: "test_secret"
    })

    {:ok, api: api, product: "product1", deployment: "1"}
  end

  test "create step", context do
    use_cassette "products/product_deployment_step/create_deployment_step", custom: true do
      step = %{completed: false}

      response = OpenAperture.ManagerApi.ProductDeploymentStep.create_step(context[:api], context[:product], context[:deployment], step)

      assert response.status == 201
      assert List.keymember?(response.headers, "location", 0)
      {_, location} = List.keyfind(response.headers, "location", 0)
      assert "https://openaperture-mgr.host.co/products/product1/deployments/1/steps/1" == location
    end
  end

  test "create! step", context do
    use_cassette "products/product_deployment_step/create_deployment_step", custom: true do
      step = %{completed: false}

      response = OpenAperture.ManagerApi.ProductDeploymentStep.create_step!(context[:api], context[:product], context[:deployment], step)

      assert response == "1"
    end
  end

  test "get step", context do
    use_cassette "products/product_deployment_step/get_deployment_step", custom: true do
      response = OpenAperture.ManagerApi.ProductDeploymentStep.get_step(context[:api], context[:product], context[:deployment], 1)

      assert response.status == 200
    end
  end

  test "get! step", context do
    use_cassette "products/product_deployment_step/get_deployment_step", custom: true do
      response = OpenAperture.ManagerApi.ProductDeploymentStep.get_step!(context[:api], context[:product], context[:deployment], 1)

      assert response == "1"
    end
  end

  test "list steps", context do
    use_cassette "products/product_deployment_step/list_deployment_step", custom: true do
      response = OpenAperture.ManagerApi.ProductDeploymentStep.list(context[:api], context[:product], context[:deployment])

      assert response.status == 200
      steps = response.body

      assert length(steps) == 2
    end
  end

  test "list! steps", context do
    use_cassette "products/product_deployment_step/list_deployment_step", custom: true do
      response = OpenAperture.ManagerApi.ProductDeploymentStep.list(context[:api], context[:product], context[:deployment])

      assert response.status == 200
      steps = response.body

      assert length(steps) == 2    
    end
  end

  test "update step", context do
    use_cassette "products/product_deployment_step/update_deployment_step", custom: true do
      response = OpenAperture.ManagerApi.ProductDeploymentStep.update_step(context[:api], context[:product], context[:deployment], 1, %{completed: true})

      assert response.status == 204
    end
  end

  test "update! step", context do
    use_cassette "products/product_deployment_step/update_deployment_step", custom: true do
      response = OpenAperture.ManagerApi.ProductDeploymentStep.update_step!(context[:api], context[:product], context[:deployment], 1, %{completed: true})

      assert response == "1"
    end
  end

  test "delete steps", context do
    use_cassette "products/product_deployment_step/delete_deployment_step", custom: true do
      response = OpenAperture.ManagerApi.ProductDeploymentStep.delete_step(context[:api], context[:product], context[:deployment], 1)

      assert response.status == 204
    end
  end

  test "delete! steps", context do
    use_cassette "products/product_deployment_step/delete_deployment_step", custom: true do
      response = OpenAperture.ManagerApi.ProductDeploymentStep.delete_step!(context[:api], context[:product], context[:deployment], 1)

      assert response == true
    end
  end
end