defmodule AlexaSkill.ColorPicker.MyColorIsIntent do
  def handle_request(request, response) do
    color = get_color(request.request.intent.slots)
    update = create_update(color)
    AlexaJSON.Response.update_response(response, update)
  end

  defp get_color(%{"Color" => %{"value" => color}}), do: color

  defp create_update(color) do
    %{
      response: %{
        shouldEndSession: false,
        outputSpeech: %{
          type: "PlainText",
          text: create_text(color)
        },
        card: %{
          content: create_content(color),
          title: "SessionSpeechlet - MyColorIsIntent",
          type: "Simple"
        },
        reprompt: %{
          outputSpeech: %{
            type: "PlainText",
            text: "You can ask me your favorite color by saying, what's my favorite color?"
          }
        }
      },
      sessionAttributes: %{"favoriteColor" => color},
      version: "1.0"
    }
  end

  defp create_text(color) do
    "I now know your favorite color is #{color}.  You can ask me your favorite color by saying, what's my favorite color?"
  end

  defp create_content(color) do
    "SessionSpeechlet - I now know your favorite color is #{color}.  You can ask me your favorite color by saying, what's my favorite color?"
  end
end
