defmodule OpenAperture.ManagerApiTest do
  use ExUnit.Case

  test "start - test starting with a supervisor" do
    Application.ensure_started(:openaperture_manager_api)
    api = OpenAperture.ManagerApi.Supervisor.get_api
    assert api != nil

    opts = OpenAperture.ManagerApi.get_options(api)
    assert opts != nil
    assert opts[:manager_url] == "https://openaperture-mgr.host.co"
    assert opts[:oauth_login_url] == "https://auth.host.co"
    assert opts[:oauth_client_id] == "id"
    assert opts[:oauth_client_secret] == "secret"
  end

  test "create - success" do
    {result, pid} = OpenAperture.ManagerApi.create(%{manager_url: "https://openaperture-mgr.host.co", oauth_login_url: "https://auth.host.co", oauth_client_id: "id", oauth_client_secret: "secret"})
    assert result == :ok
    assert is_pid pid

    opts = OpenAperture.ManagerApi.get_options(pid)
    assert opts != nil
    assert opts[:manager_url] == "https://openaperture-mgr.host.co"
    assert opts[:oauth_login_url] == "https://auth.host.co"
    assert opts[:oauth_client_id] == "id"
    assert opts[:oauth_client_secret] == "secret"    
  end

  test "create! - success" do
    pid = OpenAperture.ManagerApi.create!(%{manager_url: "https://openaperture-mgr.host.co", oauth_login_url: "https://auth.host.co", oauth_client_id: "id", oauth_client_secret: "secret"})
    assert is_pid pid

    opts = OpenAperture.ManagerApi.get_options(pid)
    assert opts != nil
    assert opts[:manager_url] == "https://openaperture-mgr.host.co"
    assert opts[:oauth_login_url] == "https://auth.host.co"
    assert opts[:oauth_client_id] == "id"
    assert opts[:oauth_client_secret] == "secret"     
  end
end
