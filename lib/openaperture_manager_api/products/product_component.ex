defmodule OpenAperture.ManagerApi.ProductComponent do
  import OpenAperture.ManagerApi.Resource

  alias OpenAperture.ManagerApi
  alias OpenAperture.ManagerApi.Response

  @spec list(pid, String.t) :: Response.t
  def list(api \\ ManagerApi.get_api, product_name) do
    get(api, get_path("products/#{product_name}/components"))
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

  @spec get_component(pid, String.t, String.t) :: Response.t
  def get_component(api \\ ManagerApi.get_api, product_name, component_name) do
    get(api, get_path("products/#{product_name}/components/#{component_name}"))
  end

  @spec get_component!(pid, String, String) :: map | nil
  def get_component!(api \\ ManagerApi.get_api, product_name, component_name) do
    response = get_component(api, product_name, component_name)
    if response.success? do
      response.body
    else
      nil
    end
  end

  @spec create_component(pid, String.t, map) :: Response.t
  def create_component(api \\ ManagerApi.get_api, product_name, component) do
    post(api, get_path("products/#{product_name}/components"), component)
  end

  @spec create_component!(pid, String.t, map) :: String.t | nil
  def create_component!(api \\ ManagerApi.get_api, product_name, component) do
    response = create_component(api, product_name, component)
    if response.success? do
      Response.extract_identifier_from_location_header(response)
    else
      nil
    end
  end

  @spec update_component(pid, String.t, String.t, map) :: Response.t
  def update_component(api \\ ManagerApi.get_api, product_name, component_name, updated_component) do
    put(api, get_path("products/#{product_name}/components/#{component_name}"), updated_component)
  end

  @spec update_component!(pid, String.t, String.t, map) :: String.t | nil
  def update_component!(api \\ ManagerApi.get_api, product_name, component_name, updated_component) do
    response = update_component(api, product_name, component_name, updated_component)
    if response.success? do
      Response.extract_identifier_from_location_header(response)
    else
      nil
    end
  end

  @spec delete_all_components(pid, String.t) :: Response.t
  def delete_all_components(api \\ ManagerApi.get_api, product_name) do
    delete(api, get_path("products/#{product_name}/components"))
  end

  @spec delete_all_components!(pid, String.t) :: boolean
  def delete_all_components!(api \\ ManagerApi.get_api, product_name) do
    response = delete_all_components(api, product_name)
    response.success?
  end

  @spec delete_component(pid, String.t, String.t) :: Response.t
  def delete_component(api \\ ManagerApi.get_api, product_name, component_name) do
    delete(api, get_path("products/#{product_name}/components/#{component_name}"))
  end

  @spec delete_component!(pid, String.t, String.t) :: boolean
  def delete_component!(api \\ ManagerApi.get_api, product_name, component_name) do
    response = delete_component(api, product_name, component_name)
    response.success?
  end
end