defmodule OpenAperture.ManagerApi.ProductDeploymentPlanStep.Test do
  use ExUnit.Case, async: false
  use ExVCR.Mock, adapter: ExVCR.Adapter.Httpc, options: [clear_mock: true]

  setup do
    api = OpenAperture.ManagerApi.create!(%{
      manager_url: "http://localhost",
      oauth_login_url: "https://localhost/oauth/token",
      oauth_client_id: "test_id",
      oauth_client_secret: "test_secret"
    })

    {:ok, api: api, product: "jordans_test_product", plan: "test_deployment_plan"}
  end

  test "create step", context do
    use_cassette "products/product_deployment_plan_step/create_step" do
      step = %{type: "deploy_component"}

      response = OpenAperture.ManagerApi.ProductDeploymentPlanStep.create_step(context[:api], context[:product], context[:plan], step)

      assert response.status == 201
      assert List.keymember?(response.headers, "location", 0)
      {_, location} = List.keyfind(response.headers, "location", 0)
      assert "/products/jordans_test_product/deployment_plans/test_deployment_plan/steps" == location
    end
  end

  test "create! step", context do
    use_cassette "products/product_deployment_plan_step/create_step" do
      step = %{type: "deploy_component"}

      response = OpenAperture.ManagerApi.ProductDeploymentPlanStep.create_step!(context[:api], context[:product], context[:plan], step)

      assert response == "steps"
    end
  end

  test "create step with options", context do
    use_cassette "products/product_deployment_plan_step/create_step_with_options" do
      options = [
        %{name: "option_1", value: "one"},
        %{name: "option_2", value: "two"},
        %{name: "option_3", value: "three"}
      ]

      build_step = %{type: "deploy_component"}

      step = %{type: "build_component", options: options, on_success_step: build_step}

      response = OpenAperture.ManagerApi.ProductDeploymentPlanStep.create_step(context[:api], context[:product], context[:plan], step)

      assert response.status == 201
      assert List.keymember?(response.headers, "location", 0)
      {_, location} = List.keyfind(response.headers, "location", 0)
      assert "/products/jordans_test_product/deployment_plans/test_deployment_plan/steps" == location
    end
  end

  test "create! step with options", context do
    use_cassette "products/product_deployment_plan_step/create_step_with_options" do
      options = [
        %{name: "option_1", value: "one"},
        %{name: "option_2", value: "two"},
        %{name: "option_3", value: "three"}
      ]

      build_step = %{type: "deploy_component"}

      step = %{type: "build_component", options: options, on_success_step: build_step}

      response = OpenAperture.ManagerApi.ProductDeploymentPlanStep.create_step!(context[:api], context[:product], context[:plan], step)

      assert response == "steps"
    end
  end

  test "list steps", context do
    use_cassette "products/product_deployment_plan_step/list_steps" do
      response = OpenAperture.ManagerApi.ProductDeploymentPlanStep.list(context[:api], context[:product], context[:plan])

      assert response.status == 200
      step = response.body

      assert step["type"] == "build_component"
      assert length(step["options"]) == 3
      assert step["on_success_step"]["type"] == "deploy_component"
    end
  end

  test "list! steps", context do
    use_cassette "products/product_deployment_plan_step/list_steps" do
      response = OpenAperture.ManagerApi.ProductDeploymentPlanStep.list!(context[:api], context[:product], context[:plan])

      assert response["type"] == "build_component"
      assert length(response["options"]) == 3
      assert response["on_success_step"]["type"] == "deploy_component"
    end
  end

  test "delete steps", context do
    use_cassette "products/product_deployment_plan_step/delete_steps" do
      response = OpenAperture.ManagerApi.ProductDeploymentPlanStep.delete_steps(context[:api], context[:product], context[:plan])

      assert response.status == 204
    end
  end

  test "delete! steps", context do
    use_cassette "products/product_deployment_plan_step/delete_steps" do
      response = OpenAperture.ManagerApi.ProductDeploymentPlanStep.delete_steps!(context[:api], context[:product], context[:plan])

      assert response == true
    end
  end
end