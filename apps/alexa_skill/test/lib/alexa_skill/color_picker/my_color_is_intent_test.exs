defmodule AlexaSkill.ColorPicker.MyColorIsIntentTest do
  use ExUnit.Case

  alias AlexaSkill.ColorPicker.MyColorIsIntent

  describe "handle_request/2" do
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

      result = MyColorIsIntent.handle_request(request, response)

      assert result.response.outputSpeech.text ==
        "I now know your favorite color is red.  You can ask me your favorite color by saying, what's my favorite color?"
    end
  end
end
