defmodule CloudOS.ManagerAPI.WorkflowTest do
  use ExUnit.Case
  use ExVCR.Mock, adapter: ExVCR.Adapter.Httpc, options: [clear_mock: true]

  alias CloudOS.ManagerAPI.Response

  setup do
    api = CloudOS.ManagerAPI.create!(%{url: "https://cloudos-mgr.host.co", client_id: "id", client_secret: "secret"})

    {:ok, [
      api: api
    ]}
  end    

  # =============================
  # list tests

  test "supervised list - success", _context do
    use_cassette "list_workflow", custom: true do
      response = CloudOS.ManagerAPI.Workflow.list
      assert response != nil
      assert response.success? == true
      assert response.status == 200

      workflows = response.body
      assert workflows != nil
      assert length(workflows) == 2
      is_successful = Enum.reduce workflows, true, fn (workflow, is_successful) ->
        if is_successful do
          cond do
            workflow["id"] == "1" && workflow["workflow_completed"] == true -> true
            workflow["id"] == "2" && workflow["workflow_completed"] == false -> true
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
    use_cassette "list_workflow", custom: true do
      response = CloudOS.ManagerAPI.Workflow.list(context[:api])
      assert response != nil
      assert response.success? == true
      assert response.status == 200

      workflows = response.body
      assert workflows != nil
      assert length(workflows) == 2
      is_successful = Enum.reduce workflows, true, fn (workflow, is_successful) ->
        if is_successful do
          cond do
            workflow["id"] == "1" && workflow["workflow_completed"] == true -> true
            workflow["id"] == "2" && workflow["workflow_completed"] == false -> true
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
    use_cassette "list_workflow_failure", custom: true do
      response = CloudOS.ManagerAPI.Workflow.list(context[:api])
      assert response != nil
      assert response.success? == false
      assert response.status == 401
    end
  end

  # =============================
  # list! tests

  test "list! - success", context do
    use_cassette "list_workflow", custom: true do
      workflows = CloudOS.ManagerAPI.Workflow.list!(context[:api])
      assert workflows != nil
      assert length(workflows) == 2
      is_successful = Enum.reduce workflows, true, fn (workflow, is_successful) ->
        if is_successful do
          cond do
            workflow["id"] == "1" && workflow["workflow_completed"] == true -> true
            workflow["id"] == "2" && workflow["workflow_completed"] == false -> true
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
    use_cassette "list_workflow_failure", custom: true do
      workflows = CloudOS.ManagerAPI.Workflow.list!(context[:api])
      assert workflows == nil
    end
  end

  # =============================
  # get_workflow tests

  test "supervised get_workflow - success", _context do
    use_cassette "get_workflow", custom: true do
      response = CloudOS.ManagerAPI.Workflow.get_workflow(1)
      assert response != nil
      assert response.success? == true
      assert response.status == 200

      workflow = response.body
      assert workflow != nil
      assert workflow["id"] == "1"
      assert workflow["workflow_completed"] == true
    end
  end

  test "get_workflow - success", context do
    use_cassette "get_workflow", custom: true do
      response = CloudOS.ManagerAPI.Workflow.get_workflow(context[:api], 1)
      assert response != nil
      assert response.success? == true
      assert response.status == 200

      workflow = response.body
      assert workflow != nil
      assert workflow["id"] == "1"
      assert workflow["workflow_completed"] == true
    end
  end

  test "get_workflow - failure", context do
    use_cassette "get_workflow_failure", custom: true do
      response = CloudOS.ManagerAPI.Workflow.get_workflow(context[:api], 1)
      assert response != nil
      assert response.success? == false
      assert response.status == 401
    end
  end

  # =============================
  # get_workflow! tests

  test "get_workflow! - success", context do
    use_cassette "get_workflow", custom: true do
      workflow = CloudOS.ManagerAPI.Workflow.get_workflow!(context[:api], 1)
      assert workflow != nil
      assert workflow["id"] == "1"
      assert workflow["workflow_completed"] == true
    end
  end

  test "get_workflow! - failure", context do
    use_cassette "get_workflow_failure", custom: true do
      workflow = CloudOS.ManagerAPI.Workflow.get_workflow!(context[:api], 1)
      assert workflow == nil
    end
  end

  # =============================
  # create_workflow tests

  test "supervised create_workflow - success", _context do
    use_cassette "create_workflow", custom: true do
      response = CloudOS.ManagerAPI.Workflow.create_workflow(%{workflow_completed: true})
      assert response != nil
      assert response.success? == true
      assert response.status == 201
      assert Response.extract_identifier_from_location_header(response) == "1"
    end
  end

  test "create_workflow - success", context do
    use_cassette "create_workflow", custom: true do
      response = CloudOS.ManagerAPI.Workflow.create_workflow(context[:api], %{workflow_completed: true})
      assert response != nil
      assert response.success? == true
      assert response.status == 201
      assert Response.extract_identifier_from_location_header(response) == "1"
    end
  end

  test "create_workflow - failure", context do
    use_cassette "create_workflow_failure", custom: true do
      response = CloudOS.ManagerAPI.Workflow.create_workflow(context[:api], %{workflow_completed: true})
      assert response != nil
      assert response.success? == false
      assert response.status == 400
    end
  end

  # =============================
  # create_workflow! tests

  test "create_workflow! - success", context do
    use_cassette "create_workflow", custom: true do
      workflow_id = CloudOS.ManagerAPI.Workflow.create_workflow!(context[:api], %{workflow_completed: true})
      assert workflow_id != nil
      assert workflow_id == "1"
    end
  end

  test "create_workflow! - failure", context do
    use_cassette "create_workflow_failure", custom: true do
      workflow_id = CloudOS.ManagerAPI.Workflow.create_workflow!(context[:api], %{workflow_completed: true})
      assert workflow_id == nil
    end
  end

  # =============================
  # update_workflow tests

  test "supervised update_workflow - success", _context do
    use_cassette "update_workflow", custom: true do
      response = CloudOS.ManagerAPI.Workflow.update_workflow(1, %{workflow_completed: true})
      assert response != nil
      assert response.success? == true
      assert response.status == 204
      assert Response.extract_identifier_from_location_header(response) == "1"
    end
  end

  test "update_workflow - success", context do
    use_cassette "update_workflow", custom: true do
      response = CloudOS.ManagerAPI.Workflow.update_workflow(context[:api], 1, %{workflow_completed: true})
      assert response != nil
      assert response.success? == true
      assert response.status == 204
      assert Response.extract_identifier_from_location_header(response) == "1"
    end
  end

  test "update_workflow - failure", context do
    use_cassette "update_workflow_failure", custom: true do
      response = CloudOS.ManagerAPI.Workflow.update_workflow(context[:api], "1", %{workflow_completed: true})
      assert response != nil
      assert response.success? == false
      assert response.status == 401
    end
  end

  # =============================
  # update_workflow! tests

  test "update_workflow! - success", context do
    use_cassette "update_workflow", custom: true do
      workflow_id = CloudOS.ManagerAPI.Workflow.update_workflow!(context[:api], "1", %{workflow_completed: true})
      assert workflow_id != nil
      assert workflow_id == "1"
    end
  end

  test "update_workflow! - failure", context do
    use_cassette "update_workflow_failure", custom: true do
      workflow_id = CloudOS.ManagerAPI.Workflow.update_workflow!(context[:api], "1", %{workflow_completed: true})
      assert workflow_id == nil
    end
  end  

  # =============================
  # delete_workflow tests

  test "supervised delete_workflow - success", _context do
    use_cassette "delete_workflow", custom: true do
      response = CloudOS.ManagerAPI.Workflow.delete_workflow("1")
      assert response != nil
      assert response.success? == true
      assert response.status == 204
    end
  end

  test "delete_workflow - success", context do
    use_cassette "delete_workflow", custom: true do
      response = CloudOS.ManagerAPI.Workflow.delete_workflow(context[:api], "1")
      assert response != nil
      assert response.success? == true
      assert response.status == 204
    end
  end

  test "delete_workflow - failure", context do
    use_cassette "delete_workflow_failure", custom: true do
      response = CloudOS.ManagerAPI.Workflow.delete_workflow(context[:api], "1")
      assert response != nil
      assert response.success? == false
      assert response.status == 401
    end
  end

  # =============================
  # delete_workflow! tests

  test "delete_workflow! - success", context do
    use_cassette "delete_workflow", custom: true do
      workflow_id = CloudOS.ManagerAPI.Workflow.delete_workflow!(context[:api], "1")
      assert workflow_id != nil
      assert workflow_id == true
    end
  end

  test "delete_workflow! - failure", context do
    use_cassette "delete_workflow_failure", custom: true do
      workflow_id = CloudOS.ManagerAPI.Workflow.delete_workflow!(context[:api], "1")
      assert workflow_id == false
    end
  end  
end