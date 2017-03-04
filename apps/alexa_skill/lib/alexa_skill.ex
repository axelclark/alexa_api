defmodule AlexaSkill do
  require Logger
  alias AlexaSkill.ColorPicker.{WhatsMyColorIntent, MyColorIsIntent}

  def handle_request(request) do
    request = AlexaJSON.Request.from_json(request)
    response = AlexaJSON.Response.create_from_request(request)

    case request.request.intent.name do
      "MyColorIsIntent" ->
        MyColorIsIntent.handle_request(request, response)
      "WhatsMyColorIntent" ->
        WhatsMyColorIntent.handle_request(request, response)
      "MetroStatus" ->
        AlexaSkill.MetroStatus.handle_request(request, response)
      "BikeShareStatus" ->
        AlexaSkill.BikeShareStatus.handle_request(request, response)
    end
  end
end
