defmodule OpenAperture.ManagerApi.ProductDeploymentStep do
  import OpenAperture.ManagerApi.Resource

  alias OpenAperture.ManagerApi
  alias OpenAperture.ManagerApi.Response

  @spec list(pid, String.t, String.t) :: Response.t
  def list(api \\ ManagerApi.get_api, product_name, deployment_id) do
    get(api, get_path("products/#{product_name}/deployments/#{deployment_id}/steps"))
  end

  @spec list!(pid, String.t, String.t) :: String.t | nil
  def list!(api \\ ManagerApi.get_api, product_name, deployment_id) do
    response = list(api, product_name, deployment_id)
    if response.success? do
      response.body
    else
      nil
    end
  end

  @spec create_step(pid, String.t, String.t) :: Response.t
  def create_step(api \\ ManagerApi.get_api, product_name, deployment_id, step) do
    post(api, get_path("products/#{product_name}/deployments/#{deployment_id}/steps"), step)
  end

  @spec create_step!(pid, String.t, String.t) :: String.t | nil
  def create_step!(api \\ ManagerApi.get_api, product_name, deployment_id, step) do
    response = create_step(api, product_name, deployment_id, step)
    if response.success? do
      Response.extract_identifier_from_location_header(response)
    else
      nil
    end
  end

  @spec update_step(pid, String.t, String.t, String.t) :: Response.t
  def update_step(api \\ ManagerApi.get_api, product_name, deployment_id, step_id, step) do
    put(api, get_path("products/#{product_name}/deployments/#{deployment_id}/steps/#{step_id}"), step)
  end

  @spec update_step!(pid, String.t, String.t, String.t) :: String.t | nil
  def update_step!(api \\ ManagerApi.get_api, product_name, deployment_id, step_id, step) do
    response = update_step(api, product_name, deployment_id, step_id, step)
    if response.success? do
      Response.extract_identifier_from_location_header(response)
    else
      nil
    end
  end

  @spec delete_step(pid, String.t, String.t, String.t) :: Response.t
  def delete_step(api \\ ManagerApi.get_api, product_name, deployment_id, step_id) do
    delete(api, get_path("products/#{product_name}/deployments/#{deployment_id}/steps/#{step_id}"))
  end

  @spec delete_step!(pid, String.t, String.t, String.t) :: boolean
  def delete_step!(api \\ ManagerApi.get_api, product_name, deployment_id, step_id) do
    response = delete_step(api, product_name, deployment_id, step_id)
    response.success?
  end  
end