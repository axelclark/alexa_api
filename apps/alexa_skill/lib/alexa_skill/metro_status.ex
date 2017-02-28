defmodule AlexaSkill.MetroStatus do
  def handle_request(request, response) do
    AlexaJSON.Response.update_response(response, get_update())
  end

  defp get_update() do
    %{
      response: %{
        shouldEndSession: true,
        outputSpeech: %{
          type: "PlainText",
          text: get_train_status()
        },
        card: %{
          content: get_train_status(),
          title: "SessionSpeechlet - WhatsMyColorIntent",
          type: "Simple"
        },
        reprompt: %{}
      },
      sessionAttributes: %{},
      version: "1.0"
    }
  end

  def get_train_status() do
    status = WMATA.get_station_info("E03", "2")
    IO.inspect status
    status
  end
end
