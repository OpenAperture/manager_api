defmodule OpenAperture.ManagerApi.ProductEnvironmentalVariable.Test do
  use ExUnit.Case, async: false
  use ExVCR.Mock, adapter: ExVCR.Adapter.Httpc, options: [clear_mock: true]

  setup do
    api = OpenAperture.ManagerApi.create!(%{
      manager_url: "http://localhost",
      oauth_login_url: "https://localhost/oauth/token",
      oauth_client_id: "test_id",
      oauth_client_secret: "test_secret"
      })

    {:ok, api: api, product: "jordans_test_product", env: "testing", var_a: "var_a", var_b: "var_b"}
  end

  test "list environment variables", context do
    use_cassette "products/product_environmental_variables/list_environment_variables" do
      response = OpenAperture.ManagerApi.ProductEnvironmentalVariable.list_environment_variables(context[:api], context[:product], context[:env])

      assert response.status == 200
      assert length(response.body) == 2
    end
  end

  test "list! environment variables", context do
    use_cassette "products/product_environmental_variables/list_environment_variables" do
      response = OpenAperture.ManagerApi.ProductEnvironmentalVariable.list_environment_variables!(context[:api], context[:product], context[:env])

      assert length(response) == 2
    end
  end

  test "list product variables", context do
    use_cassette "products/product_environmental_variables/list_product_variables" do
      response = OpenAperture.ManagerApi.ProductEnvironmentalVariable.list_product_variables(context[:api], context[:product])

      assert response.status == 200
      assert length(response.body) == 1
    end
  end

  test "list! product variables", context do
    use_cassette "products/product_environmental_variables/list_product_variables" do
      response = OpenAperture.ManagerApi.ProductEnvironmentalVariable.list_product_variables!(context[:api], context[:product])

      assert length(response) == 1
    end
  end

  test "list product variables -- coalesced", context do
    use_cassette "products/product_environmental_variables/list_product_variables_coalesced" do
      response = OpenAperture.ManagerApi.ProductEnvironmentalVariable.list_product_variables(context[:api], context[:product], true)

      assert response.status == 200
      assert length(response.body) == 3
    end
  end

  test "list! product variables -- coalesced", context do
    use_cassette "products/product_environmental_variables/list_product_variables_coalesced" do
      response = OpenAperture.ManagerApi.ProductEnvironmentalVariable.list_product_variables!(context[:api], context[:product], true)

      assert length(response) == 3
    end
  end

  test "get environment variable", context do
    use_cassette "products/product_environmental_variables/get_environment_variable" do
      response = OpenAperture.ManagerApi.ProductEnvironmentalVariable.get_environment_variable(context[:api], context[:product], context[:env], context[:var_b])

      assert response.status == 200
      assert response.body["name"] == "var_b"
      assert response.body["value"] == "b"
    end
  end

  test "get! environment variable", context do
    use_cassette "products/product_environmental_variables/get_environment_variable" do
      response = OpenAperture.ManagerApi.ProductEnvironmentalVariable.get_environment_variable!(context[:api], context[:product], context[:env], context[:var_b])

      assert response["name"] == "var_b"
      assert response["value"] == "b"
    end
  end

  test "get product variable", context do
    use_cassette "products/product_environmental_variables/get_product_variable" do
      response = OpenAperture.ManagerApi.ProductEnvironmentalVariable.get_product_variable(context[:api], context[:product], context[:var_a])

      assert response.status == 200
      assert length(response.body) == 1
    end
  end

  test "get! product variable", context do
    use_cassette "products/product_environmental_variables/get_product_variable" do
      response = OpenAperture.ManagerApi.ProductEnvironmentalVariable.get_product_variable!(context[:api], context[:product], context[:var_a])

      assert length(response) == 1
    end
  end

  test "get product variable -- coalesced", context do
    use_cassette "products/product_environmental_variables/get_product_variable_coalesced" do
      response = OpenAperture.ManagerApi.ProductEnvironmentalVariable.get_product_variable(context[:api], context[:product], context[:var_a], true)

      assert response.status == 200
      assert length(response.body) == 2
    end
  end

  test "get! product variable -- coalesced", context do
    use_cassette "products/product_environmental_variables/get_product_variable_coalesced" do
      response = OpenAperture.ManagerApi.ProductEnvironmentalVariable.get_product_variable!(context[:api], context[:product], context[:var_a], true)

      assert length(response) == 2
    end
  end

  test "create environment variable", context do
    use_cassette "products/product_environmental_variables/create_environment_variable" do
      variable = %{name: "test_variable", value: "test_value"}
      response = OpenAperture.ManagerApi.ProductEnvironmentalVariable.create_environment_variable(context[:api], context[:product], context[:env], variable)

      assert response.status == 201
      assert List.keymember?(response.headers, "location", 0)
      {_, location} = List.keyfind(response.headers, "location", 0)
      assert "/products/jordans_test_product/environments/testing/variables/test_variable" == location
    end
  end

  test "create! environment variable", context do
    use_cassette "products/product_environmental_variables/create_environment_variable" do
      variable = %{name: "test_variable", value: "test_value"}
      response = OpenAperture.ManagerApi.ProductEnvironmentalVariable.create_environment_variable!(context[:api], context[:product], context[:env], variable)

      assert "test_variable" == response
    end
  end

  test "create product variable", context do
    use_cassette "products/product_environmental_variables/create_product_variable" do
      variable = %{name: "test_variable", value: "test_value"}
      response = OpenAperture.ManagerApi.ProductEnvironmentalVariable.create_product_variable(context[:api], context[:product], variable)

      assert response.status == 201
      assert List.keymember?(response.headers, "location", 0)
      {_, location} = List.keyfind(response.headers, "location", 0)
      assert "/products/jordans_test_product/environmental_variables/test_variable" == location
    end
  end

  test "create! product variable", context do
    use_cassette "products/product_environmental_variables/create_product_variable" do
      variable = %{name: "test_variable", value: "test_value"}
      response = OpenAperture.ManagerApi.ProductEnvironmentalVariable.create_product_variable!(context[:api], context[:product], variable)

      assert "test_variable" == response
    end
  end

  test "update environment variable", context do
    use_cassette "products/product_environmental_variables/update_environment_variable" do
      updated_variable = %{name: "updated_var_a", value: "updated_a"}
      response = OpenAperture.ManagerApi.ProductEnvironmentalVariable.update_environment_variable(context[:api], context[:product], context[:env], context[:var_a], updated_variable)

      assert response.status == 204
      assert List.keymember?(response.headers, "location", 0)
      {_, location} = List.keyfind(response.headers, "location", 0)
      assert "/products/jordans_test_product/environments/testing/variables/updated_var_a" == location
    end
  end

  test "update! environment variable", context do
    use_cassette "products/product_environmental_variables/update_environment_variable" do
      updated_variable = %{name: "updated_var_a", value: "updated_a"}
      response = OpenAperture.ManagerApi.ProductEnvironmentalVariable.update_environment_variable!(context[:api], context[:product], context[:env], context[:var_a], updated_variable)

      assert "updated_var_a" == response
    end
  end

  test "update product variable", context do
    use_cassette "products/product_environmental_variables/update_product_variable" do
      updated_variable = %{name: "updated_var_a", value: "updated_a"}
      response = OpenAperture.ManagerApi.ProductEnvironmentalVariable.update_product_variable(context[:api], context[:product], context[:var_a], updated_variable)

      assert response.status == 204
      assert List.keymember?(response.headers, "location", 0)
      {_, location} = List.keyfind(response.headers, "location", 0)
      assert "/products/jordans_test_product/environmental_variables/updated_var_a" == location
    end
  end

  test "update! product variable", context do
    use_cassette "products/product_environmental_variables/update_product_variable" do
      updated_variable = %{name: "updated_var_a", value: "updated_a"}
      response = OpenAperture.ManagerApi.ProductEnvironmentalVariable.update_product_variable!(context[:api], context[:product], context[:var_a], updated_variable)

      assert "updated_var_a" == response
    end
  end

  test "delete environment variable", context do
    use_cassette "products/product_environmental_variables/delete_environment_variable" do
      response = OpenAperture.ManagerApi.ProductEnvironmentalVariable.delete_environment_variable(context[:api], context[:product], context[:env], "test_variable")

      assert response.status == 204
    end
  end

  test "delete! environment variable", context do
    use_cassette "products/product_environmental_variables/delete_environment_variable" do
      response = OpenAperture.ManagerApi.ProductEnvironmentalVariable.delete_environment_variable!(context[:api], context[:product], context[:env], "test_variable")

      assert response == true
    end
  end

  test "delete product variable", context do
    use_cassette "products/product_environmental_variables/delete_product_variable" do
      response = OpenAperture.ManagerApi.ProductEnvironmentalVariable.delete_product_variable(context[:api], context[:product], "test_variable")

      assert response.status == 204
    end
  end

  test "delete! product variable", context do
    use_cassette "products/product_environmental_variables/delete_product_variable" do
      response = OpenAperture.ManagerApi.ProductEnvironmentalVariable.delete_product_variable!(context[:api], context[:product], "test_variable")

      assert response == true
    end
  end
  
end