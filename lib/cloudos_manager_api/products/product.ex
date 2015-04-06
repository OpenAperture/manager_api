defmodule CloudOS.ManagerAPI.Product do
  import CloudOS.ManagerAPI.Resource

  alias CloudOS.ManagerAPI
  alias CloudOS.ManagerAPI.Response

  @spec list(pid) :: Response.t
  def list(api \\ ManagerAPI.get_api) do
    get(api, get_path("products"))
  end

  @spec list!(pid) :: List.t | nil
  def list!(api \\ ManagerAPI.get_api) do
    response = list(api)
    if response.success? do
      response.body
    else
      nil
    end
  end

  @spec get_product(pid, String.t) :: Response.t
  def get_product(api \\ ManagerAPI.get_api, product_name) do
    get(api, get_path("products/#{product_name}"))
  end

  @spec get_product!(pid, String.t) :: Map.t | nil
  def get_product!(api \\ ManagerAPI.get_api, product_name) do
    response = get(api, product_name)
    if response.success? do
      response.body
    else
      nil
    end
  end

  @spec create_product(pid, Map.t) :: Response.t
  def create_product(api \\ ManagerAPI.get_api, product) do
    post(api, get_path("products"), product)
  end

  @spec create_product!(pid, Map.t) :: String.t
  def create_product!(api \\ ManagerAPI.get_api, product) do
    response = create_product(api, product)
    if response.success? do
      Response.extract_identifier_from_location_header(response)
    else
      nil
    end
  end

  @spec delete_product(pid, String.t) :: Response.t
  def delete_product(api \\ ManagerAPI.get_api, product_name) do
    delete(api, get_path("products/#{product_name}"))
  end

  @spec delete_product!(pid, String.t) :: boolean
  def delete_product!(api \\ ManagerAPI.get_api, product_name) do
    response = delete_product(api, product_name)
    response.success?
  end

  @spec update_product(pid, String.t, Map.t) :: Response.t
  def update_product(api \\ ManagerAPI.get_api, product_name, product) do
    put(api, get_path("products/#{product_name}"), product)
  end

  @spec update_product(pid, String.t, Map.t) :: String.t | nil
  def update_product!(api \\ ManagerAPI.get_api, product_name, product) do
    response = update_product(api, product_name, product)
    if response.success? do
      Response.extract_identifier_from_location_header(response)
    else
      nil
    end
  end
end