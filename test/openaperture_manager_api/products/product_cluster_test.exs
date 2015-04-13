defmodule OpenAperture.ManagerApi.ProductCluster.Test do
  use ExUnit.Case, async: false
  use ExVCR.Mock, adapter: ExVCR.Adapter.Httpc, options: [clear_mock: true]

  setup do
    api = OpenAperture.ManagerApi.create!(%{
      manager_url: "http://localhost",
      oauth_login_url: "https://localhost/oauth/token",
      oauth_client_id: "test_id",
      oauth_client_secret: "test_secret"
    })

    {:ok, api: api, product: "jordans_test_product", etcd_clusters: [%{"id" => 2}, %{"id" => 3}]}
  end

  test "list clusters", context do
    use_cassette "products/product_cluster/list_clusters" do
      response = OpenAperture.ManagerApi.ProductCluster.list(context[:api], context[:product])

      assert response.status == 200
      assert length(response.body) == 2
    end
  end

  test "list! clusters", context do
    use_cassette "products/product_cluster/list_clusters" do
      response = OpenAperture.ManagerApi.ProductCluster.list!(context[:api], context[:product])

      assert length(response) == 2
    end
  end

  test "create clusters", context do
    use_cassette "products/product_cluster/create_clusters" do
      response = OpenAperture.ManagerApi.ProductCluster.create_clusters(context[:api], context[:product], context[:etcd_clusters])

      assert response.status == 201
    end
  end

  test "create! clusters", context do
    use_cassette "products/product_cluster/create_clusters" do
      response = OpenAperture.ManagerApi.ProductCluster.create_clusters!(context[:api], context[:product], context[:etcd_clusters])

      assert response == true
    end
  end

  test "delete clusters", context do
    use_cassette "products/product_cluster/delete_clusters" do
      response = OpenAperture.ManagerApi.ProductCluster.delete_clusters(context[:api], context[:product])

      assert response.status == 204
    end
  end

  test "delete! clusters", context do
    use_cassette "products/product_cluster/delete_clusters" do
      response = OpenAperture.ManagerApi.ProductCluster.delete_clusters!(context[:api], context[:product])

      assert response == true
    end
  end  
end