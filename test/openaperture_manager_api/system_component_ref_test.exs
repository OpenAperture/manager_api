defmodule OpenAperture.ManagerApi.SystemComponentRefTest do
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
  # list_system_component_ref tests

  test "supervised list_system_component_ref - success", _context do
    use_cassette "list_system_component_ref", custom: true do
      response = OpenAperture.ManagerApi.SystemComponentRef.list
      assert response != nil
      assert response.success? == true
      assert response.status == 200

      components = response.body
      assert components != nil
      assert length(components) == 2
      is_successful = Enum.reduce components, true, fn (component, is_successful) ->
        if is_successful do
          cond do
            component["id"] == "1" -> true
            component["id"] == "2" -> true
            true -> false
          end
        else
          is_successful
        end
      end
      assert is_successful == true
    end
  end

  test "list_system_component_ref - success", context do
    use_cassette "list_system_component_ref", custom: true do
      response = OpenAperture.ManagerApi.SystemComponentRef.list(context[:api])
      assert response != nil
      assert response.success? == true
      assert response.status == 200

      components = response.body
      assert components != nil
      assert length(components) == 2
      is_successful = Enum.reduce components, true, fn (component, is_successful) ->
        if is_successful do
          cond do
            component["id"] == "1" -> true
            component["id"] == "2" -> true
            true -> false
          end
        else
          is_successful
        end
      end
      assert is_successful == true
    end
  end

  test "list_system_component_ref - failure", context do
    use_cassette "list_system_component_ref_failure", custom: true do
      response = OpenAperture.ManagerApi.SystemComponentRef.list(context[:api])
      assert response != nil
      assert response.success? == false
      assert response.status == 401
    end
  end

  # =============================
  # list! tests

  test "list_system_component_ref! - success", context do
    use_cassette "list_system_component_ref", custom: true do
      components = OpenAperture.ManagerApi.SystemComponentRef.list!(context[:api])
      assert components != nil
      assert length(components) == 2
      is_successful = Enum.reduce components, true, fn (component, is_successful) ->
        if is_successful do
          cond do
            component["id"] == "1" -> true
            component["id"] == "2" -> true
            true -> false
          end
        else
          is_successful
        end
      end
      assert is_successful == true
    end
  end

  test "list_system_component_ref! - failure", context do
    use_cassette "list_system_component_ref_failure", custom: true do
      components = OpenAperture.ManagerApi.SystemComponentRef.list!(context[:api])
      assert components == nil
    end
  end

  # =============================
  # get_system_component_ref tests

  test "supervised get_system_component_ref - success", _context do
    use_cassette "get_system_component_ref", custom: true do
      response = OpenAperture.ManagerApi.SystemComponentRef.get_system_component_ref(1)
      assert response != nil
      assert response.success? == true
      assert response.status == 200

      component = response.body
      assert component != nil
      assert component["id"] == "1"
    end
  end

  test "get_system_component_ref - success", context do
    use_cassette "get_system_component_ref", custom: true do
      response = OpenAperture.ManagerApi.SystemComponentRef.get_system_component_ref(context[:api], 1)
      assert response != nil
      assert response.success? == true
      assert response.status == 200

      component = response.body
      assert component != nil
      assert component["id"] == "1"
    end
  end

  test "get_system_component_ref - failure", context do
    use_cassette "get_system_component_ref_failure", custom: true do
      response = OpenAperture.ManagerApi.SystemComponentRef.get_system_component_ref(context[:api], 1)
      assert response != nil
      assert response.success? == false
      assert response.status == 401
    end
  end

  # =============================
  # get_system_component_ref! tests

  test "get_system_component_ref! - success", context do
    use_cassette "get_system_component_ref", custom: true do
      component = OpenAperture.ManagerApi.SystemComponentRef.get_system_component_ref!(context[:api], 1)
      assert component != nil
      assert component["id"] == "1"
    end
  end

  test "get_system_component_ref! - failure", context do
    use_cassette "get_system_component_ref_failure", custom: true do
      component = OpenAperture.ManagerApi.SystemComponentRef.get_system_component_ref!(context[:api], 1)
      assert component == nil
    end
  end

  # =============================
  # create_system_component_ref tests

  test "supervised create_system_component_ref - success", _context do
    use_cassette "create_system_component_ref", custom: true do
      response = OpenAperture.ManagerApi.SystemComponentRef.create_system_component_ref(%{})
      assert response != nil
      assert response.success? == true
      assert response.status == 201
      assert Response.extract_identifier_from_location_header(response) == "1"
    end
  end

  test "create_system_component_ref - success", context do
    use_cassette "create_system_component_ref", custom: true do
      response = OpenAperture.ManagerApi.SystemComponentRef.create_system_component_ref(context[:api], %{})
      assert response != nil
      assert response.success? == true
      assert response.status == 201
      assert Response.extract_identifier_from_location_header(response) == "1"
    end
  end

  test "create_system_component_ref - failure", context do
    use_cassette "create_system_component_ref_failure", custom: true do
      response = OpenAperture.ManagerApi.SystemComponentRef.create_system_component_ref(context[:api], %{})
      assert response != nil
      assert response.success? == false
      assert response.status == 400
    end
  end

  # =============================
  # create_system_component_ref! tests

  test "create_system_component_ref! - success", context do
    use_cassette "create_system_component_ref", custom: true do
      component = OpenAperture.ManagerApi.SystemComponentRef.create_system_component_ref!(context[:api], %{})
      assert component != nil
      assert component == "1"
    end
  end

  test "create_system_component_ref! - failure", context do
    use_cassette "create_system_component_ref_failure", custom: true do
      component = OpenAperture.ManagerApi.SystemComponentRef.create_system_component_ref!(context[:api], %{})
      assert component == nil
    end
  end  

  # =============================
  # update_system_component_ref tests

  test "supervised update_system_component_ref - success", _context do
    use_cassette "update_system_component_ref", custom: true do
      response = OpenAperture.ManagerApi.SystemComponentRef.update_system_component_ref(1, %{})
      assert response != nil
      assert response.success? == true
      assert response.status == 204
      assert Response.extract_identifier_from_location_header(response) == "1"
    end
  end

  test "update_system_component_ref - success", context do
    use_cassette "update_system_component_ref", custom: true do
      response = OpenAperture.ManagerApi.SystemComponentRef.update_system_component_ref(context[:api], 1, %{})
      assert response != nil
      assert response.success? == true
      assert response.status == 204
      assert Response.extract_identifier_from_location_header(response) == "1"
    end
  end

  test "update_system_component_ref - failure", context do
    use_cassette "update_system_component_ref_failure", custom: true do
      response = OpenAperture.ManagerApi.SystemComponentRef.update_system_component_ref(context[:api], "1", %{})
      assert response != nil
      assert response.success? == false
      assert response.status == 401
    end
  end

  # =============================
  # update_system_component_ref! tests

  test "update_system_component_ref! - success", context do
    use_cassette "update_system_component_ref", custom: true do
      component = OpenAperture.ManagerApi.SystemComponentRef.update_system_component_ref!(context[:api], "1", %{})
      assert component != nil
      assert component == "1"
    end
  end

  test "update_system_component_ref! - failure", context do
    use_cassette "update_system_component_ref_failure", custom: true do
      component = OpenAperture.ManagerApi.SystemComponentRef.update_system_component_ref!(context[:api], "1", %{})
      assert component == nil
    end
  end 

  # =============================
  # delete_system_component_ref tests

  test "supervised delete_system_component_ref - success", _context do
    use_cassette "delete_system_component_ref", custom: true do
      response = OpenAperture.ManagerApi.SystemComponentRef.delete_system_component_ref("1")
      assert response != nil
      assert response.success? == true
      assert response.status == 204
    end
  end

  test "delete_system_component_ref - success", context do
    use_cassette "delete_system_component_ref", custom: true do
      response = OpenAperture.ManagerApi.SystemComponentRef.delete_system_component_ref(context[:api], "1")
      assert response != nil
      assert response.success? == true
      assert response.status == 204
    end
  end

  test "delete_system_component_ref - failure", context do
    use_cassette "delete_system_component_ref_failure", custom: true do
      response = OpenAperture.ManagerApi.SystemComponentRef.delete_system_component_ref(context[:api], "1")
      assert response != nil
      assert response.success? == false
      assert response.status == 401
    end
  end

  # =============================
  # delete_system_component_ref! tests

  test "delete_system_component_ref! - success", context do
    use_cassette "delete_system_component_ref", custom: true do
      component = OpenAperture.ManagerApi.SystemComponentRef.delete_system_component_ref!(context[:api], "1")
      assert component != nil
      assert component == true
    end
  end

  test "delete_system_component_ref! - failure", context do
    use_cassette "delete_system_component_ref_failure", custom: true do
      component = OpenAperture.ManagerApi.SystemComponentRef.delete_system_component_ref!(context[:api], "1")
      assert component == false
    end
  end     
end