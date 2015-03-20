defmodule ResponseTest do
  use ExUnit.Case

  alias CloudOS.ManagerAPI.Response

  test "process a successful request" do
    api_response = {:ok, %{status_code: 200, headers: [{'Content-Type', 'application/json'}], body: "{\"cool\": \"a cool response\"}"}}
    response = Response.process(fn -> api_response end)

    assert response.success? == true
    assert response.status == 200
    assert response.body["cool"] == "a cool response"
  end

  test "process a complex JSON object" do
    api_response = {:ok, %{status_code: 200, headers: [{'Content-Type', 'application/json'}], body: "{\"node\": {\"id\": 1, \"name\": \"test\"}}"}}
    response = Response.process(fn -> api_response end)

    assert response.body["node"] == %{"id" => 1, "name" => "test"}
  end

  test "process retains raw body" do
    api_response = {:ok, %{status_code: 200, headers: [{'Content-Type', 'application/json'}], body: "{\"node\": {\"id\": 1, \"name\": \"test\"}}"}}
    response = Response.process(fn -> api_response end)

    assert response.raw_body == "{\"node\": {\"id\": 1, \"name\": \"test\"}}"
  end

  test "process headers with multiple values" do
    api_response = {:ok, %{status_code: 200, headers: [{'cont', '[]'}], body: "{\"cool\": \"a cool response\"}"}}
    response = Response.process(fn -> api_response end)

    assert response.success? == true
    assert response.status == 200
    assert response.body["cool"] == "a cool response"
  end
end
