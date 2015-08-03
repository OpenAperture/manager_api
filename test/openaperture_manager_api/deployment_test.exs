defmodule OpenAperture.ManagerApi.DeploymentTest do
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

  test "supervised list - success", _context do
    use_cassette "list_deployment", custom: true do
      response = OpenAperture.ManagerApi.Deployment.list("product1")
      assert response != nil
      assert response.success? == true
      assert response.status == 200

      deployments = response.body
      assert deployments != nil
      assert length(deployments) == 2
      is_successful = Enum.reduce deployments, true, fn (deployment, is_successful) ->
        if is_successful do
          cond do
            deployment["id"] == "1" && deployment["product_id"] == "1" && deployment["product_deployment_plan_id"] == "1" -> true
            deployment["id"] == "2" && deployment["product_id"] == "1" && deployment["product_deployment_plan_id"] == "2" -> true
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
    use_cassette "list_deployment", custom: true do
      response = OpenAperture.ManagerApi.Deployment.list(context[:api], "product1")
      assert response != nil
      assert response.success? == true
      assert response.status == 200

      deployments = response.body
      assert deployments != nil
      assert length(deployments) == 2
      is_successful = Enum.reduce deployments, true, fn (deployment, is_successful) ->
        if is_successful do
           cond do
            deployment["id"] == "1" && deployment["product_id"] == "1" && deployment["product_deployment_plan_id"] == "1" -> true
            deployment["id"] == "2" && deployment["product_id"] == "1" && deployment["product_deployment_plan_id"] == "2" -> true
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
    use_cassette "list_deployment_failure", custom: true do
      response = OpenAperture.ManagerApi.Deployment.list(context[:api], "product1")
      assert response != nil
      assert response.success? == false
      assert response.status == 401
    end
  end

  # =============================
  # list! tests

  test "list! - success", context do
    use_cassette "list_deployment", custom: true do
      deployments = OpenAperture.ManagerApi.Deployment.list!(context[:api], "product1")
      assert deployments != nil
      assert length(deployments) == 2
      is_successful = Enum.reduce deployments, true, fn (deployment, is_successful) ->
        if is_successful do
           cond do
            deployment["id"] == "1" && deployment["product_id"] == "1" && deployment["product_deployment_plan_id"] == "1" -> true
            deployment["id"] == "2" && deployment["product_id"] == "1" && deployment["product_deployment_plan_id"] == "2" -> true
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
    use_cassette "list_deployment_failure", custom: true do
      deployments = OpenAperture.ManagerApi.Deployment.list!(context[:api], "product1")
      assert deployments == nil
    end
  end

  # =============================
  # get_deployment tests

  test "supervised get_deployment - success", _context do
    use_cassette "get_deployment", custom: true do
      response = OpenAperture.ManagerApi.Deployment.get_deployment("product1", 1)
      assert response != nil
      assert response.success? == true
      assert response.status == 200

      deployment = response.body
      assert deployment != nil
      assert deployment["id"] == "1"
      assert deployment["product_id"] == "1"
      assert deployment["product_deployment_plan_id"] == "1"
    end
  end

  test "get_deployment - success", context do
    use_cassette "get_deployment", custom: true do
      response = OpenAperture.ManagerApi.Deployment.get_deployment(context[:api], "product1", 1)
      assert response != nil
      assert response.success? == true
      assert response.status == 200

      deployment = response.body
      assert deployment != nil
      assert deployment["id"] == "1"
      assert deployment["product_id"] == "1"
      assert deployment["product_deployment_plan_id"] == "1"
    end
  end

  test "get_deployment - failure", context do
    use_cassette "get_deployment_failure", custom: true do
      response = OpenAperture.ManagerApi.Deployment.get_deployment(context[:api], "product1", 1)
      assert response != nil
      assert response.success? == false
      assert response.status == 401
    end
  end

  # =============================
  # get_deployment! tests

  test "get_deployment! - success", context do
    use_cassette "get_deployment", custom: true do
      deployment = OpenAperture.ManagerApi.Deployment.get_deployment!(context[:api], "product1", 1)
      assert deployment != nil
      assert deployment["id"] == "1"
      assert deployment["product_id"] == "1"
      assert deployment["product_deployment_plan_id"] == "1"
    end
  end

  test "get_deployment! - failure", context do
    use_cassette "get_deployment_failure", custom: true do
      deployment = OpenAperture.ManagerApi.Deployment.get_deployment!(context[:api], "product1", 1)
      assert deployment == nil
    end
  end

  # =============================
  # create_deployment tests

  test "supervised create_deployment - success", _context do
    use_cassette "create_deployment", custom: true do
      response = OpenAperture.ManagerApi.Deployment.create_deployment("product1", %{product_id: 1, product_deployment_plan_id: 1})
      assert response != nil
      assert response.success? == true
      assert response.status == 201
      assert Response.extract_identifier_from_location_header(response) == "1"
    end
  end

  test "create_deployment - success", context do
    use_cassette "create_deployment", custom: true do
      response = OpenAperture.ManagerApi.Deployment.create_deployment(context[:api], "product1", %{product_id: 1, product_deployment_plan_id: 1})
      assert response != nil
      assert response.success? == true
      assert response.status == 201
      assert Response.extract_identifier_from_location_header(response) == "1"
    end
  end

  test "create_deployment - failure", context do
    use_cassette "create_deployment_failure", custom: true do
      response = OpenAperture.ManagerApi.Deployment.create_deployment(context[:api], "product1", %{product_id: 1, product_deployment_plan_id: 1})
      assert response != nil
      assert response.success? == false
      assert response.status == 400
    end
  end

  # =============================
  # create_deployment! tests

  test "create_deployment! - success", context do
    use_cassette "create_deployment", custom: true do
      deployment_id = OpenAperture.ManagerApi.Deployment.create_deployment!(context[:api], "product1", %{product_id: 1, product_deployment_plan_id: 1})
      assert deployment_id != nil
      assert deployment_id == "1"
    end
  end

  test "create_deployment! - failure", context do
    use_cassette "create_deployment_failure", custom: true do
      deployment_id = OpenAperture.ManagerApi.Deployment.create_deployment!(context[:api], "product1", %{product_id: 1, product_deployment_plan_id: 1})
      assert deployment_id == nil
    end
  end

  # =============================
  # update_deployment tests

  test "supervised update_deployment - success", _context do
    use_cassette "update_deployment", custom: true do
      response = OpenAperture.ManagerApi.Deployment.update_deployment("product1", "1", %{output: "['yooooo']"})
      assert response != nil
      assert response.success? == true
      assert response.status == 204
      assert Response.extract_identifier_from_location_header(response) == "1"
    end
  end

  test "update_deployment - success", context do
    use_cassette "update_deployment", custom: true do
      response = OpenAperture.ManagerApi.Deployment.update_deployment(context[:api], "product1", "1", %{output: "['yooooo']"})
      assert response != nil
      assert response.success? == true
      assert response.status == 204
      assert Response.extract_identifier_from_location_header(response) == "1"
    end
  end

  test "update_deployment - failure", context do
    use_cassette "update_deployment_failure", custom: true do
      response = OpenAperture.ManagerApi.Deployment.update_deployment(context[:api], "product1", "1", %{output: "['yooooo']"})
      assert response != nil
      assert response.success? == false
      assert response.status == 401
    end
  end

  # =============================
  # update_deployment! tests

  test "update_deployment! - success", context do
    use_cassette "update_deployment", custom: true do
      deployment_id = OpenAperture.ManagerApi.Deployment.update_deployment!(context[:api], "product1", "1", %{output: "['yooooo']"})
      assert deployment_id != nil
      assert deployment_id == "1"
    end
  end

  test "update_deployment! - failure", context do
    use_cassette "update_deployment_failure", custom: true do
      deployment_id = OpenAperture.ManagerApi.Deployment.update_deployment!(context[:api], "product1", "1", %{output: "['yooooo']"})
      assert deployment_id == nil
    end
  end  

  # =============================
  # delete_deployment tests

  test "supervised delete_deployment - success", _context do
    use_cassette "delete_deployment", custom: true do
      response = OpenAperture.ManagerApi.Deployment.delete_deployment("product1", "1")
      assert response != nil
      assert response.success? == true
      assert response.status == 204
    end
  end

  test "delete_deployment - success", context do
    use_cassette "delete_deployment", custom: true do
      response = OpenAperture.ManagerApi.Deployment.delete_deployment(context[:api], "product1", "1")
      assert response != nil
      assert response.success? == true
      assert response.status == 204
    end
  end

  test "delete_deployment - failure", context do
    use_cassette "delete_deployment_failure", custom: true do
      response = OpenAperture.ManagerApi.Deployment.delete_deployment(context[:api], "product1", "1")
      assert response != nil
      assert response.success? == false
      assert response.status == 401
    end
  end

  # =============================
  # delete_deployment! tests

  test "delete_deployment! - success", context do
    use_cassette "delete_deployment", custom: true do
      deployment_id = OpenAperture.ManagerApi.Deployment.delete_deployment!(context[:api], "product1", "1")
      assert deployment_id != nil
      assert deployment_id == true
    end
  end

  test "delete_deployment! - failure", context do
    use_cassette "delete_deployment_failure", custom: true do
      deployment_id = OpenAperture.ManagerApi.Deployment.delete_deployment!(context[:api], "product1", "1")
      assert deployment_id == false
    end
  end  








  # =============================
  # execute_deployment tests

  test "supervised execute_deployment - success", _context do
    use_cassette "execute_deployment", custom: true do
      response = OpenAperture.ManagerApi.Deployment.execute_deployment("product1", "1")
      assert response != nil
      assert response.success? == true
      assert response.status == 204
    end
  end

  test "execute_deployment - success", context do
    use_cassette "execute_deployment", custom: true do
      response = OpenAperture.ManagerApi.Deployment.execute_deployment(context[:api], "product1", "1")
      assert response != nil
      assert response.success? == true
      assert response.status == 204
    end
  end

  test "execute_deployment - failure", context do
    use_cassette "execute_deployment_failure", custom: true do
      response = OpenAperture.ManagerApi.Deployment.execute_deployment(context[:api], "product1", "1")
      assert response != nil
      assert response.success? == false
      assert response.status == 401
    end
  end

  # =============================
  # execute_deployment! tests

  test "execute_deployment! - success", context do
    use_cassette "execute_deployment", custom: true do
      deployment_id = OpenAperture.ManagerApi.Deployment.execute_deployment!(context[:api], "product1", "1")
      assert deployment_id == true
    end
  end

  test "execute_deployment! - failure", context do
    use_cassette "execute_deployment_failure", custom: true do
      deployment_id = OpenAperture.ManagerApi.Deployment.execute_deployment!(context[:api], "product1", "1")
      assert deployment_id == false
    end
  end  

end