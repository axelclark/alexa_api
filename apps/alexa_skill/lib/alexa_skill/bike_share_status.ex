defmodule AlexaSkill.BikeShareStatus do
  def handle_request(_request, response) do
    AlexaJSON.Response.update_response(response, get_update())
  end

  defp get_update() do
    %{
      response: %{
        shouldEndSession: true,
        outputSpeech: %{
          type: "PlainText",
          text: get_bike_status()
        },
        card: %{
          content: get_bike_status(),
          title: "SessionSpeechlet - BikeShareStatus",
          type: "Simple"
        },
        reprompt: %{}
      },
      sessionAttributes: %{},
      version: "1.0"
    }
  end

  def get_bike_status() do
    BikeShare.get_station_info(102)
  end
end
