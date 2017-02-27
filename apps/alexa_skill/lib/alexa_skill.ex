defmodule AlexaSkill do
  alias AlexaSkill.ColorPicker.{MyColorIsIntent}

  def handle_request(request) do
    request = AlexaJSON.Request.from_json(request)
    response = AlexaJSON.Response.create_from_request(request)

    case request.request.intent.name do
      "MyColorIsIntent" ->
        MyColorIsIntent.handle_request(request, response)
    end
  end
end
