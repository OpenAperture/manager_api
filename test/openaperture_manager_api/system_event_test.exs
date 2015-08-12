defmodule OpenAperture.ManagerApi.SystemEventTest do
  use ExUnit.Case
  use ExVCR.Mock, adapter: ExVCR.Adapter.Httpc, options: [clear_mock: true]

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
    use_cassette "list_system_event", custom: true do
      response = OpenAperture.ManagerApi.SystemEvent.list
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
    use_cassette "list_system_event", custom: true do
      response = OpenAperture.ManagerApi.SystemEvent.list(context[:api])
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
    use_cassette "list_system_event_failure", custom: true do
      response = OpenAperture.ManagerApi.SystemEvent.list(context[:api])
      assert response != nil
      assert response.success? == false
      assert response.status == 401
    end
  end

  # =============================
  # list! tests

  test "list! - success", context do
    use_cassette "list_system_event", custom: true do
      workflows = OpenAperture.ManagerApi.SystemEvent.list!(context[:api])
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
    use_cassette "list_system_event_failure", custom: true do
      workflows = OpenAperture.ManagerApi.SystemEvent.list!(context[:api])
      assert workflows == nil
    end
  end

  # =============================
  # create_system_event tests

  test "supervised create_system_event - success", _context do
    use_cassette "create_system_event", custom: true do
      response = OpenAperture.ManagerApi.SystemEvent.create_system_event(%{})
      assert response != nil
      assert response.success? == true
      assert response.status == 201
    end
  end

  test "create_system_event - success", context do
    use_cassette "create_system_event", custom: true do
      response = OpenAperture.ManagerApi.SystemEvent.create_system_event(context[:api], %{})
      assert response != nil
      assert response.success? == true
      assert response.status == 201
    end
  end

  test "create_system_event - failure", context do
    use_cassette "create_system_event_failure", custom: true do
      response = OpenAperture.ManagerApi.SystemEvent.create_system_event(context[:api], %{})
      assert response != nil
      assert response.success? == false
      assert response.status == 400
    end
  end

  # =============================
  # create_system_event! tests

  test "create_system_event! - success", context do
    use_cassette "create_system_event", custom: true do
      created = OpenAperture.ManagerApi.SystemEvent.create_system_event!(context[:api], %{})
      assert created == true
    end
  end

  test "create_system_event! - failure", context do
    use_cassette "create_system_event_failure", custom: true do
      created = OpenAperture.ManagerApi.SystemEvent.create_system_event!(context[:api], %{})
      assert created == false
    end
  end  
end