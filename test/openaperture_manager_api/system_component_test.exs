defmodule OpenAperture.ManagerApi.SystemComponentTest do
  use ExUnit.Case
  use ExVCR.Mock, adapter: ExVCR.Adapter.Httpc, options: [clear_mock: true]

  alias OpenAperture.ManagerApi.Response

  setup_all _context do
    :meck.new(OpenAperture.Auth.Client, [:passthrough])
    :meck.expect(OpenAperture.Auth.Client, :get_token, fn _, _, _ -> "abc" end)

    on_exit _context, fn ->
      try do
        :meck.unload OpenAperture.Auth.Client
      rescue _ -> IO.puts "" end
    end    
    :ok
  end

  setup do
    api = OpenAperture.ManagerApi.create!(%{manager_url: "https://openaperture-mgr.host.co", oauth_login_url: "https://auth.host.co", oauth_client_id: "id", oauth_client_secret: "secret"})

    {:ok, [
      api: api
    ]}
  end    

  # =============================
  # list tests

  test "supervised list - success", _context do
    use_cassette "list_system_component", custom: true do
      response = OpenAperture.ManagerApi.SystemComponent.list
      assert response != nil
      assert response.success? == true
      assert response.status == 200

      workflows = response.body
      assert workflows != nil
      assert length(workflows) == 2
      is_successful = Enum.reduce workflows, true, fn (workflow, is_successful) ->
        if is_successful do
          cond do
            workflow["id"] == "1" -> true
            workflow["id"] == "2" -> true
            true -> false
          end
        else
          is_successful
        end
      end
      assert is_successful == true
    end
  end

  test "list - success", context do
    use_cassette "list_system_component", custom: true do
      response = OpenAperture.ManagerApi.SystemComponent.list(context[:api])
      assert response != nil
      assert response.success? == true
      assert response.status == 200

      workflows = response.body
      assert workflows != nil
      assert length(workflows) == 2
      is_successful = Enum.reduce workflows, true, fn (workflow, is_successful) ->
        if is_successful do
          cond do
            workflow["id"] == "1" -> true
            workflow["id"] == "2" -> true
            true -> false
          end
        else
          is_successful
        end
      end
      assert is_successful == true
    end
  end

  test "list - failure", context do
    use_cassette "list_system_component_failure", custom: true do
      response = OpenAperture.ManagerApi.SystemComponent.list(context[:api])
      assert response != nil
      assert response.success? == false
      assert response.status == 401
    end
  end

  # =============================
  # list! tests

  test "list! - success", context do
    use_cassette "list_system_component", custom: true do
      workflows = OpenAperture.ManagerApi.SystemComponent.list!(context[:api])
      assert workflows != nil
      assert length(workflows) == 2
      is_successful = Enum.reduce workflows, true, fn (workflow, is_successful) ->
        if is_successful do
          cond do
            workflow["id"] == "1" -> true
            workflow["id"] == "2" -> true
            true -> false
          end
        else
          is_successful
        end
      end
      assert is_successful == true
    end
  end

  test "list! - failure", context do
    use_cassette "list_system_component_failure", custom: true do
      workflows = OpenAperture.ManagerApi.SystemComponent.list!(context[:api])
      assert workflows == nil
    end
  end

  # =============================
  # get_system_component tests

  test "supervised get_system_component - success", _context do
    use_cassette "get_system_component", custom: true do
      response = OpenAperture.ManagerApi.SystemComponent.get_system_component(1)
      assert response != nil
      assert response.success? == true
      assert response.status == 200

      workflow = response.body
      assert workflow != nil
      assert workflow["id"] == "1"
    end
  end

  test "get_system_component - success", context do
    use_cassette "get_system_component", custom: true do
      response = OpenAperture.ManagerApi.SystemComponent.get_system_component(context[:api], 1)
      assert response != nil
      assert response.success? == true
      assert response.status == 200

      workflow = response.body
      assert workflow != nil
      assert workflow["id"] == "1"
    end
  end

  test "get_system_component - failure", context do
    use_cassette "get_system_component_failure", custom: true do
      response = OpenAperture.ManagerApi.SystemComponent.get_system_component(context[:api], 1)
      assert response != nil
      assert response.success? == false
      assert response.status == 401
    end
  end

  # =============================
  # get_system_component! tests

  test "get_system_component! - success", context do
    use_cassette "get_system_component", custom: true do
      workflow = OpenAperture.ManagerApi.SystemComponent.get_system_component!(context[:api], 1)
      assert workflow != nil
      assert workflow["id"] == "1"
    end
  end

  test "get_system_component! - failure", context do
    use_cassette "get_system_component_failure", custom: true do
      workflow = OpenAperture.ManagerApi.SystemComponent.get_system_component!(context[:api], 1)
      assert workflow == nil
    end
  end

  # =============================
  # create_system_component tests

  test "supervised create_system_component - success", _context do
    use_cassette "create_system_component", custom: true do
      response = OpenAperture.ManagerApi.SystemComponent.create_system_component(%{})
      assert response != nil
      assert response.success? == true
      assert response.status == 201
      assert Response.extract_identifier_from_location_header(response) == "1"
    end
  end

  test "create_system_component - success", context do
    use_cassette "create_system_component", custom: true do
      response = OpenAperture.ManagerApi.SystemComponent.create_system_component(context[:api], %{})
      assert response != nil
      assert response.success? == true
      assert response.status == 201
      assert Response.extract_identifier_from_location_header(response) == "1"
    end
  end

  test "create_system_component - failure", context do
    use_cassette "create_system_component_failure", custom: true do
      response = OpenAperture.ManagerApi.SystemComponent.create_system_component(context[:api], %{})
      assert response != nil
      assert response.success? == false
      assert response.status == 400
    end
  end

  # =============================
  # create_system_component! tests

  test "create_system_component! - success", context do
    use_cassette "create_system_component", custom: true do
      workflow_id = OpenAperture.ManagerApi.SystemComponent.create_system_component!(context[:api], %{})
      assert workflow_id != nil
      assert workflow_id == "1"
    end
  end

  test "create_system_component! - failure", context do
    use_cassette "create_system_component_failure", custom: true do
      workflow_id = OpenAperture.ManagerApi.SystemComponent.create_system_component!(context[:api], %{})
      assert workflow_id == nil
    end
  end  

  # =============================
  # update_system_component tests

  test "supervised update_system_component - success", _context do
    use_cassette "update_system_component", custom: true do
      response = OpenAperture.ManagerApi.SystemComponent.update_system_component(1, %{workflow_completed: true})
      assert response != nil
      assert response.success? == true
      assert response.status == 204
      assert Response.extract_identifier_from_location_header(response) == "1"
    end
  end

  test "update_system_component - success", context do
    use_cassette "update_system_component", custom: true do
      response = OpenAperture.ManagerApi.SystemComponent.update_system_component(context[:api], 1, %{workflow_completed: true})
      assert response != nil
      assert response.success? == true
      assert response.status == 204
      assert Response.extract_identifier_from_location_header(response) == "1"
    end
  end

  test "update_system_component - failure", context do
    use_cassette "update_system_component_failure", custom: true do
      response = OpenAperture.ManagerApi.SystemComponent.update_system_component(context[:api], "1", %{workflow_completed: true})
      assert response != nil
      assert response.success? == false
      assert response.status == 401
    end
  end

  # =============================
  # update_system_component! tests

  test "update_system_component! - success", context do
    use_cassette "update_system_component", custom: true do
      workflow_id = OpenAperture.ManagerApi.SystemComponent.update_system_component!(context[:api], "1", %{workflow_completed: true})
      assert workflow_id != nil
      assert workflow_id == "1"
    end
  end

  test "update_system_component! - failure", context do
    use_cassette "update_system_component_failure", custom: true do
      workflow_id = OpenAperture.ManagerApi.SystemComponent.update_system_component!(context[:api], "1", %{workflow_completed: true})
      assert workflow_id == nil
    end
  end    

  # =============================
  # delete_system_component tests

  test "supervised delete_system_component - success", _context do
    use_cassette "delete_system_component", custom: true do
      response = OpenAperture.ManagerApi.SystemComponent.delete_system_component("1")
      assert response != nil
      assert response.success? == true
      assert response.status == 204
    end
  end

  test "delete_system_component - success", context do
    use_cassette "delete_system_component", custom: true do
      response = OpenAperture.ManagerApi.SystemComponent.delete_system_component(context[:api], "1")
      assert response != nil
      assert response.success? == true
      assert response.status == 204
    end
  end

  test "delete_system_component - failure", context do
    use_cassette "delete_system_component_failure", custom: true do
      response = OpenAperture.ManagerApi.SystemComponent.delete_system_component(context[:api], "1")
      assert response != nil
      assert response.success? == false
      assert response.status == 401
    end
  end

  # =============================
  # delete_system_component! tests

  test "delete_system_component! - success", context do
    use_cassette "delete_system_component", custom: true do
      workflow_id = OpenAperture.ManagerApi.SystemComponent.delete_system_component!(context[:api], "1")
      assert workflow_id != nil
      assert workflow_id == true
    end
  end

  test "delete_system_component! - failure", context do
    use_cassette "delete_system_component_failure", custom: true do
      workflow_id = OpenAperture.ManagerApi.SystemComponent.delete_system_component!(context[:api], "1")
      assert workflow_id == false
    end
  end   
end