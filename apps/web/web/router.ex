defmodule Web.Router do
  use Web.Web, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", Web do
    pipe_through :api

    resources "/alexa_skills", AlexaSkillController, only: [:create]
  end
end
