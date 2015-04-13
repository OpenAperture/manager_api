defmodule OpenAperture.ManagerApi.ProductCluster do
  import OpenAperture.ManagerApi.Resource

  alias OpenAperture.ManagerApi
  alias OpenAperture.ManagerApi.Response

  @type etcd_cluster :: Map.t

  @spec list(pid, String.t) :: Response.t
  def list(api \\ ManagerApi.get_api, product_name) do
    get(api, get_path("products/#{product_name}/clusters"))
  end

  @spec list!(pid, String.t) :: [Map.t] | nil
  def list!(api \\ ManagerApi.get_api, product_name) do
    response = list(api, product_name)
    if response.success? do
      response.body
    else
      nil
    end
  end

  @spec create_clusters(pid, String.t, [etcd_cluster]) :: Response.t
  def create_clusters(api \\ ManagerApi.get_api, product_name, etcd_clusters) do
    post(api, get_path("products/#{product_name}/clusters"), %{"clusters" => etcd_clusters})
  end

  @spec create_clusters!(pid, String.t, [etcd_cluster]) :: boolean
  def create_clusters!(api \\ ManagerApi.get_api, product_name, etcd_clusters) do
    response = create_clusters(api, product_name, etcd_clusters)
    response.success?
  end

  @spec delete_clusters(pid, String.t) :: Response.t
  def delete_clusters(api \\ ManagerApi.get_api, product_name) do
    delete(api, get_path("products/#{product_name}/clusters"))
  end

  @spec delete_clusters!(pid, String.t) :: boolean
  def delete_clusters!(api \\ ManagerApi.get_api, product_name) do
    response = delete_clusters(api, product_name)
    response.success?
  end
  
end