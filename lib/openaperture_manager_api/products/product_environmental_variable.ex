defmodule OpenAperture.ManagerApi.ProductEnvironmentalVariable do
  import OpenAperture.ManagerApi.Resource

  alias OpenAperture.ManagerApi
  alias OpenAperture.ManagerApi.Response

  @spec list_environment_variables(pid, String.t, String.t) :: Response.t
  def list_environment_variables(api \\ ManagerApi.get_api, product_name, environment_name) do
    get(api, get_path("products/#{product_name}/environments/#{environment_name}/variables"))
  end

  @spec list_environment_variables!(pid, String.t, String.t) :: List.t | nil
  def list_environment_variables!(api \\ ManagerApi.get_api, product_name, environment_name) do
    response = list_environment_variables(api, product_name, environment_name)
    if response.success? do
      response.body
    else
      nil
    end
  end

  @spec list_product_variables(pid, String.t, boolean) :: Response.t
  def list_product_variables(api \\ ManagerApi.get_api, product_name, include_environment_variables \\ false) do
    path = if include_environment_variables do
      get_path("products/#{product_name}/environmental_variables?coalesced=true")
    else
      get_path("products/#{product_name}/environmental_variables")
    end

    get(api, path)
  end

  @spec list_product_variables!(pid, String.t, boolean) :: List.t | nil
  def list_product_variables!(api \\ ManagerApi.get_api, product_name, include_environment_variables \\ false) do
    response = list_product_variables(api, product_name, include_environment_variables)
    if response.success? do
      response.body
    else
      nil
    end
  end

  @spec get_environment_variable(pid, String.t, String.t, String.t) :: Response.t
  def get_environment_variable(api \\ ManagerApi.get_api, product_name, environment_name, variable_name) do
    get(api, get_path("products/#{product_name}/environments/#{environment_name}/variables/#{variable_name}"))
  end

  @spec get_environment_variable!(pid, String.t, String.t, String.t) :: Map.t | nil
  def get_environment_variable!(api \\ ManagerApi.get_api, product_name, environment_name, variable_name) do
    response = get_environment_variable(api, product_name, environment_name, variable_name)
    if response.success? do
      response.body
    else
      nil
    end
  end

  @spec get_product_variable(pid, String.t, String.t, boolean) :: Response.t
  def get_product_variable(api \\ ManagerApi.get_api, product_name, variable_name, include_environment_variables \\ false) do
    path = if include_environment_variables do
      get_path("products/#{product_name}/environmental_variables/#{variable_name}?coalesced=true")
    else
      get_path("products/#{product_name}/environmental_variables/#{variable_name}")
    end

    get(api, path)
  end

  @spec get_product_variable!(pid, String.t, String.t, boolean) :: List.t | nil
  def get_product_variable!(api \\ ManagerApi.get_api, product_name, variable_name, include_environment_variables \\ false) do
    response = get_product_variable(api, product_name, variable_name, include_environment_variables)
    if response.success? do
      response.body
    else
      nil
    end
  end

  @spec create_environment_variable(pid, String.t, String.t, Map.t) :: Response.t
  def create_environment_variable(api \\ ManagerApi.get_api, product_name, environment_name, variable) do
    post(api, get_path("products/#{product_name}/environments/#{environment_name}/variables"), variable)
  end

  @spec create_environment_variable!(pid, String.t, String.t, Map.t) :: String.t | nil
  def create_environment_variable!(api \\ ManagerApi.get_api, product_name, environment_name, variable) do
    response = create_environment_variable(api, product_name, environment_name, variable)
    if response.success? do
      Response.extract_identifier_from_location_header(response)
    else
      nil
    end
  end

  @spec create_product_variable(pid, String.t, Map.t) :: Response.t
  def create_product_variable(api \\ ManagerApi.get_api, product_name, variable) do
    post(api, get_path("products/#{product_name}/environmental_variables"), variable)
  end

  @spec create_product_variable(pid, String.t, Map.t) :: String.t | nil
  def create_product_variable!(api \\ ManagerApi.get_api, product_name, variable) do
    response = create_product_variable(api, product_name, variable)
    if response.success? do
      Response.extract_identifier_from_location_header(response)
    else
      nil
    end
  end

  @spec update_environment_variable(pid, String.t, String.t, String.t, Map.t) :: Response.t
  def update_environment_variable(api \\ ManagerApi.get_api, product_name, environment_name, variable_name, variable) do
    put(api, get_path("products/#{product_name}/environments/#{environment_name}/variables/#{variable_name}"), variable)
  end

  @spec update_environment_variable!(pid, String.t, String.t, String.t, Map.t) :: String.t | nil
  def update_environment_variable!(api \\ ManagerApi.get_api, product_name, environment_name, variable_name, variable) do
    response = update_environment_variable(api, product_name, environment_name, variable_name, variable)
    if response.success? do
      Response.extract_identifier_from_location_header(response)
    else
      nil
    end
  end

  @spec update_product_variable(pid, String.t, String.t, Map.t) :: Response.t
  def update_product_variable(api \\ ManagerApi.get_api, product_name, variable_name, variable) do
    put(api, get_path("products/#{product_name}/environmental_variables/#{variable_name}"), variable)
  end

  @spec update_product_variable!(pid, String.t, String.t, Map.t) :: String.t | nil
  def update_product_variable!(api \\ ManagerApi.get_api, product_name, variable_name, variable) do
    response = update_product_variable(api, product_name, variable_name, variable)
    if response.success? do
      Response.extract_identifier_from_location_header(response)
    else
      nil
    end
  end

  @spec delete_environment_variable(pid, String.t, String.t, String.t) :: Response.t
  def delete_environment_variable(api \\ ManagerApi.get_api, product_name, environment_name, variable_name) do
    delete(api, get_path("products/#{product_name}/environments/#{environment_name}/variables/#{variable_name}"))
  end

  @spec delete_environment_variable!(pid, String.t, String.t, String.t) :: boolean
  def delete_environment_variable!(api \\ ManagerApi.get_api, product_name, environment_name, variable_name) do
    response = delete_environment_variable(api, product_name, environment_name, variable_name)
    response.success?
  end

  @spec delete_product_variable(pid, String.t, String.t) :: Response.t
  def delete_product_variable(api \\ ManagerApi.get_api, product_name, variable_name) do
    delete(api, get_path("products/#{product_name}/environmental_variables/#{variable_name}"))
  end

  @spec delete_product_variable(pid, String.t, String.t) :: boolean
  def delete_product_variable!(api \\ ManagerApi.get_api, product_name, variable_name) do
    response = delete_product_variable(api, product_name, variable_name)
    response.success?
  end
  
end