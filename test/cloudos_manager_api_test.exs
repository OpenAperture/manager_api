defmodule CloudOS.ManagerAPITest do
  use ExUnit.Case

  test "start - test starting with a supervisor" do
    Application.ensure_started(:cloudos_manager_api)
    api = CloudOS.ManagerAPI.Supervisor.get_api
    assert api != nil

    opts = CloudOS.ManagerAPI.get_options(api)
    assert opts != nil
    assert opts[:manager_url] == "https://cloudos-mgr.host.co"
    assert opts[:oauth_login_url] == "https://auth.host.co"
    assert opts[:oauth_client_id] == "id"
    assert opts[:oauth_client_secret] == "secret"
  end

  test "create - success" do
    {result, pid} = CloudOS.ManagerAPI.create(%{manager_url: "https://cloudos-mgr.host.co", oauth_login_url: "https://auth.host.co", oauth_client_id: "id", oauth_client_secret: "secret"})
    assert result == :ok
    assert is_pid pid

    opts = CloudOS.ManagerAPI.get_options(pid)
    assert opts != nil
    assert opts[:manager_url] == "https://cloudos-mgr.host.co"
    assert opts[:oauth_login_url] == "https://auth.host.co"
    assert opts[:oauth_client_id] == "id"
    assert opts[:oauth_client_secret] == "secret"    
  end

  test "create! - success" do
    pid = CloudOS.ManagerAPI.create!(%{manager_url: "https://cloudos-mgr.host.co", oauth_login_url: "https://auth.host.co", oauth_client_id: "id", oauth_client_secret: "secret"})
    assert is_pid pid

    opts = CloudOS.ManagerAPI.get_options(pid)
    assert opts != nil
    assert opts[:manager_url] == "https://cloudos-mgr.host.co"
    assert opts[:oauth_login_url] == "https://auth.host.co"
    assert opts[:oauth_client_id] == "id"
    assert opts[:oauth_client_secret] == "secret"     
  end
end
