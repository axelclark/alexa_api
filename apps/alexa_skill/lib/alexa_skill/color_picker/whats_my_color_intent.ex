defmodule AlexaSkill.ColorPicker.WhatsMyColorIntent do
  def handle_request(
    %{session: %{attributes: %{"favoriteColor" => color}}} =
    request, response
  ) do
    update = create_update(color)
    AlexaJSON.Response.update_response(response, update)
  end

  def handle_request(_request, response) do
    AlexaJSON.Response.update_response(response, no_color())
  end

  defp create_update(color) do
    %{
      response: %{
        shouldEndSession: true,
        outputSpeech: %{
          type: "PlainText",
          text: create_text(color)
        },
        card: %{
          content: create_content(color),
          title: "SessionSpeechlet - WhatsMyColorIntent",
          type: "Simple"
        },
        reprompt: %{}
      },
      sessionAttributes: %{"favoriteColor" => color},
      version: "1.0"
    }
  end

  defp create_text(color) do
    "Your favorite color is #{color}. Goodbye."
  end

  defp create_content(color) do
    "SessionSpeechlet - Your favorite color is #{color}. Goodbye."
  end

  defp no_color() do
    %{
      response: %{
        shouldEndSession: false,
        outputSpeech: %{
          type: "PlainText",
          text: "I'm not sure what your favorite color is. You can say, my favorite color is red."
        },
        card: %{
          content: "SessionSpeechlet - I'm not sure what your favorite color is. You can say, my favorite color is red.",
          title: "SessionSpeechlet - WhatsMyColorIntent",
          type: "Simple"
        },
        reprompt: %{}
      },
      sessionAttributes: %{},
      version: "1.0"
    }
  end
end
