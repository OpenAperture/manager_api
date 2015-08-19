defmodule OpenAperture.ManagerApi.ProductDeploymentPlan do
  import OpenAperture.ManagerApi.Resource

  alias OpenAperture.ManagerApi
  alias OpenAperture.ManagerApi.Response

  @spec list(pid, String.t) :: Response.t
  def list(api \\ ManagerApi.get_api, product_name) do
    get(api, get_path("products/#{product_name}/deployment_plans"))
  end

  @spec list!(pid, String.t) :: List | nil
  def list!(api \\ ManagerApi.get_api, product_name) do
    response = list(api, product_name)
    if response.success? do
      response.body
    else
      nil
    end
  end

  @spec get_deployment_plan(pid, String.t, String.t) :: Response.t
  def get_deployment_plan(api \\ ManagerApi.get_api, product_name, deployment_plan_name) do
    get(api, get_path("products/#{product_name}/deployment_plans/#{deployment_plan_name}"))
  end

  @spec get_deployment_plan!(pid, String.t, String.t) :: Map | nil
  def get_deployment_plan!(api \\ ManagerApi.get_api, product_name, deployment_plan_name) do
    response = get_deployment_plan(api, product_name, deployment_plan_name)
    if response.success? do
      response.body
    else
      nil
    end
  end

  @spec create_deployment_plan(pid, String.t, Map) :: Response.t
  def create_deployment_plan(api \\ ManagerApi.get_api, product_name, deployment_plan) do
    post(api, get_path("products/#{product_name}/deployment_plans"), deployment_plan)
  end

  @spec create_deployment_plan!(pid, String.t, Map) :: String.t | nil
  def create_deployment_plan!(api \\ ManagerApi.get_api, product_name, deployment_plan) do
    response = create_deployment_plan(api, product_name, deployment_plan)
    if response.success? do
      Response.extract_identifier_from_location_header(response)
    else
      nil
    end
  end

  @spec update_deployment_plan(pid, String.t, String.t, Map) :: Response.t
  def update_deployment_plan(api \\ ManagerApi.get_api, product_name, deployment_plan_name, updated_deployment_plan) do
    put(api, get_path("products/#{product_name}/deployment_plans/#{deployment_plan_name}"), updated_deployment_plan)
  end

  @spec update_deployment_plan!(pid, String.t, String.t, Map) :: String.t | nil
  def update_deployment_plan!(api \\ ManagerApi.get_api, product_name, deployment_plan_name, updated_deployment_plan) do
    response = update_deployment_plan(api, product_name, deployment_plan_name, updated_deployment_plan)
    if response.success? do
      Response.extract_identifier_from_location_header(response)
    else
      nil
    end
  end

  @spec delete_all_deployment_plans(pid, String.t) :: Response.t
  def delete_all_deployment_plans(api \\ ManagerApi.get_api, product_name) do
    delete(api, get_path("products/#{product_name}/deployment_plans"))
  end

  @spec delete_all_deployment_plans!(pid, String.t) :: boolean
  def delete_all_deployment_plans!(api \\ ManagerApi.get_api, product_name) do
    response = delete_all_deployment_plans(api, product_name)
    response.success?
  end

  @spec delete_deployment_plan(pid, String.t, String.t) :: Response.t
  def delete_deployment_plan(api \\ ManagerApi.get_api, product_name, deployment_plan_name) do
    delete(api, get_path("products/#{product_name}/deployment_plans/#{deployment_plan_name}"))
  end

  @spec delete_deployment_plan!(pid, String.t, String.t) :: boolean
  def delete_deployment_plan!(api \\ ManagerApi.get_api, product_name, deployment_plan_name) do
    response = delete_deployment_plan(api, product_name, deployment_plan_name)
    response.success?
  end
end