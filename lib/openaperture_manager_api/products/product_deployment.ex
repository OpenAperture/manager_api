defmodule OpenAperture.ManagerApi.ProductDeployment do
  import OpenAperture.ManagerApi.Resource

  alias OpenAperture.ManagerApi
  alias OpenAperture.ManagerApi.Response

  @spec list(pid, String) :: Response.t
  def list(api \\ ManagerApi.get_api, product_name) do
    get(api, get_path("products/#{product_name}/deployments"))
  end

  @spec list!(pid, String) :: List | nil
  def list!(api \\ ManagerApi.get_api, product_name) do
    response = list(api, product_name)
    if response.success? do
      response.body
    else
      nil
    end
  end

  @spec get_deployment(pid, String.t, integer) :: Response.t
  def get_deployment(api \\ ManagerApi.get_api, product_name, deployment_id) do
    get(api, get_path("products/#{product_name}/deployments/#{deployment_id}"))
  end

  @spec get_deployment!(pid, String.t, integer) :: Map | nil
  def get_deployment!(api \\ ManagerApi.get_api, product_name, deployment_id) do
    response = get_deployment(api, product_name, deployment_id)
    if response.success? do
      response.body
    else
      nil
    end
  end

  @spec get_deployment_steps(pid, String.t, integer) :: Response.t
  def get_deployment_steps(api \\ ManagerApi.get_api, product_name, deployment_id) do
    get(api, get_path("products/#{product_name}/deployments/#{deployment_id}/steps"))
  end

  @spec get_deployment_steps!(pid, String.t, integer) :: List | nil
  def get_deployment_steps!(api \\ ManagerApi.get_api, product_name, deployment_id) do
    response = get_deployment_steps(api, product_name, deployment_id)
    if response.success? do
      response.body
    else
      nil
    end
  end

  @spec create_deployment(pid, String.t, String.t, Map) :: Response.t
  def create_deployment(api \\ ManagerApi.get_api, product_name, deployment_plan_name, deployment) do
    deployment = Map.put(deployment, :plan_name, deployment_plan_name)
    post(api, get_path("products/#{product_name}/deployments"), deployment)
  end

  @spec create_deployment!(pid, String.t, String.t, Map) :: integer | nil
  def create_deployment!(api \\ ManagerApi.get_api, product_name, deployment_plan_name, deployment) do
    response = create_deployment(api, product_name, deployment_plan_name, deployment)
    if response.success? do
      Response.extract_identifier_from_location_header(response)
    else
      nil
    end
  end

  @spec delete_deployment(pid, String.t, integer) :: Response.t
  def delete_deployment(api \\ ManagerApi.get_api, product_name, deployment_id) do
    delete(api, get_path("products/#{product_name}/deployments/#{deployment_id}"))
  end

  @spec delete_deployment!(pid, String.t, integer) :: boolean
  def delete_deployment!(api \\ ManagerApi.get_api, product_name, deployment_id) do
    response = delete_deployment(api, product_name, deployment_id)
    response.success?
  end
end