defmodule Web.AlexaSkillController do
  use Web.Web, :controller

  def create(conn, _params) do
    json conn, %{}
  end
end
