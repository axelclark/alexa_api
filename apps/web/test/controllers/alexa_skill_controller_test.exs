defmodule Web.AlexaSkillControllerTest do
  use Web.ConnCase

  describe "create/2" do
    test "returns JSON response" do
      conn = build_conn()
      params = %{}

      conn = post conn, alexa_skill_path(conn, :create, params)

      assert json_response(conn, 200) == %{}
    end
  end
end
