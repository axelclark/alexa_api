defmodule AlexaSkill do
  def handle_request(request) do
    request = AlexaJSON.Request.from_json(request)
    response = AlexaJSON.Response.create_from_request(request)

    case request.request.intent.name do
      "MyColorIsIntent" ->
        AlexaSkill.ColorPicker.my_color_intent(request, response)
    end
  end
end
