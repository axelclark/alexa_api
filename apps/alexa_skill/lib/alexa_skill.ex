defmodule AlexaSkill do
  def handle_request(request) do
    outputSpeech =
      %{response: %{outputSpeech: %{type: "PlainText", text: "hi, Nana"}}}

    request
    |> AlexaJSON.Request.from_json
    |> AlexaJSON.Response.create_from_request
    |> AlexaJSON.Response.update_response(outputSpeech)
  end
end
