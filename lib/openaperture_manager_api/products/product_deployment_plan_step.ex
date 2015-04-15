defmodule OpenAperture.ManagerApi.ProductDeploymentPlanStep do
  import OpenAperture.ManagerApi.Resource

  alias OpenAperture.ManagerApi
  alias OpenAperture.ManagerApi.Response

  @spec list(pid, String.t, String.t) :: Response.t
  def list(api \\ ManagerApi.get_api, product_name, deployment_plan_name) do
    get(api, get_path("products/#{product_name}/deployment_plans/#{deployment_plan_name}/steps"))
  end

  @spec list!(pid, String.t, String.t) :: String.t | nil
  def list!(api \\ ManagerApi.get_api, product_name, deployment_plan_name) do
    response = list(api, product_name, deployment_plan_name)
    if response.success? do
      response.body
    else
      nil
    end
  end

  @spec create_step(pid, String.t, String.t) :: Response.t
  def create_step(api \\ ManagerApi.get_api, product_name, deployment_plan_name, step) do
    post(api, get_path("products/#{product_name}/deployment_plans/#{deployment_plan_name}/steps"), step)
  end

  @spec create_step!(pid, String.t, String.t) :: String.t | nil
  def create_step!(api \\ ManagerApi.get_api, product_name, deployment_plan_name, step) do
    response = create_step(api, product_name, deployment_plan_name, step)
    if response.success? do
      Response.extract_identifier_from_location_header(response)
    else
      nil
    end
  end

  @spec delete_steps(pid, String.t, String.t) :: Response.t
  def delete_steps(api \\ ManagerApi.get_api, product_name, deployment_plan_name) do
    delete(api, get_path("products/#{product_name}/deployment_plans/#{deployment_plan_name}/steps"))
  end

  @spec delete_steps!(pid, String.t, String.t) :: boolean
  def delete_steps!(api \\ ManagerApi.get_api, product_name, deployment_plan_name) do
    response = delete_steps(api, product_name, deployment_plan_name)
    response.success?
  end  
end