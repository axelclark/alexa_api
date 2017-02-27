defmodule AlexaSkill.ColorPickerTest do
  use ExUnit.Case

  describe "my_color_intent/2" do
    test "returns response to MyColorIsIntent" do
      request =
        %AlexaJSON.Request{
          request: %AlexaJSON.RequestElement{
            inDialog: false,
            intent: %AlexaJSON.Intent{
              name: "MyColorIsIntent",
              slots: %{
                "Color" => %{"name" => "Color", "value" => "red"}
              }
            },
            locale: "en-US",
            requestId: "request123",
            timestamp: nil,
            type: "IntentRequest"
          },
          session: %AlexaJSON.Session{
            application: %AlexaJSON.Application{
              applicationId: "appId123"
            },
            attributes: %{},
            new: true,
            sessionId: "session123",
            user: %AlexaJSON.User{userId: "user123"}
          },
          version: "1.0"
        }
      response = AlexaJSON.Response.create_from_request(request)

      result = AlexaSkill.ColorPicker.my_color_intent(request, response)

      assert result.response.outputSpeech.text ==
        "I now know your favorite color is red.  You can ask me your favorite color by saying, what's my favorite color?"
    end
  end
end
