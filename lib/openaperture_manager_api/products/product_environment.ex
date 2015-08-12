defmodule OpenAperture.ManagerApi.ProductEnvironment do
  import OpenAperture.ManagerApi.Resource

  alias OpenAperture.ManagerApi
  alias OpenAperture.ManagerApi.Response

  @spec list(pid, String.t) :: Response.t
  def list(api \\ ManagerApi.get_api, product_name) do
    get(api, get_path("products/#{product_name}/environments"))
  end

  @spec list!(pid, String.t) :: List | nil
  def list!(api \\ ManagerApi.get_api, product_name) do
    response = get(api, get_path("products/#{product_name}/environments"))
    if response.success? do
      response.body
    else
      nil
    end
  end

  @spec get_environment(pid, String.t, String.t) :: Response.t
  def get_environment(api \\ ManagerApi.get_api, product_name, environment_name) do
    get(api, get_path("products/#{product_name}/environments/#{environment_name}"))
  end

  @spec get_environment!(pid, String.t, String.t) :: Map | nil
  def get_environment!(api \\ ManagerApi.get_api, product_name, environment_name) do
    response = get_environment(api, product_name, environment_name)
    if response.success? do
      response.body
    else
      nil
    end
  end

  @spec create_environment(pid, String.t, Map) :: Response.t
  def create_environment(api \\ ManagerApi.get_api, product_name, environment) do
    post(api, get_path("products/#{product_name}/environments"), environment)
  end

  @spec create_environment!(pid, String.t, Map) :: String.t | nil
  def create_environment!(api \\ ManagerApi.get_api, product_name, environment) do
    response = create_environment(api, product_name, environment)
    if response.success? do
      Response.extract_identifier_from_location_header(response)
    else
      nil
    end
  end

  @spec delete_environment(pid, String.t, String.t) :: Response.t
  def delete_environment(api \\ ManagerApi.get_api, product_name, environment_name) do
    delete(api, get_path("products/#{product_name}/environments/#{environment_name}"))
  end

  @spec delete_environment!(pid, String.t, String.t) :: boolean
  def delete_environment!(api \\ ManagerApi.get_api, product_name, environment_name) do
    response = delete_environment(api, product_name, environment_name)
    response.success?
  end

  @spec update_environment(pid, String.t, String.t, Map) :: Response.t
  def update_environment(api \\ ManagerApi.get_api, product_name, environment_name, environment) do
    put(api, get_path("products/#{product_name}/environments/#{environment_name}"), environment)
  end

  @spec update_environment!(pid, String.t, String.t, Map) :: String.t | nil
  def update_environment!(api \\ ManagerApi.get_api, product_name, environment_name, environment) do
    response = update_environment(api, product_name, environment_name, environment)
    if response.success? do
      Response.extract_identifier_from_location_header(response)
    else
      nil
    end
  end
end