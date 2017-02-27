defmodule Web.AlexaSkillController do
  use Web.Web, :controller

  def create(conn, params) do
    response = AlexaSkill.handle_request(params)

    json conn, response
  end
end
